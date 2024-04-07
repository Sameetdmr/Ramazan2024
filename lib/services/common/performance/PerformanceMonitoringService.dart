import 'package:firebase_performance/firebase_performance.dart';
import 'package:http/http.dart';

abstract class IPerformanceMonitoringService {
  Future<HttpMetric> startHttpMetric(String endpoint, HttpMethod httpMethod);
  Future<void> stopHttpMetric(String endpoint, HttpMetric httpMetric, Response response);
}

final class PerformanceMonitoringService extends IPerformanceMonitoringService {
  final FirebasePerformance _performance = FirebasePerformance.instance;
  Trace? _trace;

  @override
  Future<HttpMetric> startHttpMetric(String endpoint, HttpMethod httpMethod) async {
    final metric = _performance.newHttpMetric(endpoint, httpMethod);
    await metric.start();
    await _startTrace();
    return metric;
  }

  @override
  Future<void> stopHttpMetric(String endpoint, HttpMetric httpMetric, Response response) async {
    httpMetric.httpResponseCode = response.statusCode;
    _trace?.setMetric(endpoint, response.statusCode);
    await _trace?.stop();
  }

  Future<void> _startTrace() async {
    _trace = _performance.newTrace('service-trace');
    await _trace?.start();
  }
}
