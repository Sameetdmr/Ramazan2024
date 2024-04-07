// ignore_for_file: null_argument_to_non_null_type, unnecessary_new, cascade_invocations, prefer_collection_literals, prefer_final_locals, omit_local_variable_types, depend_on_referenced_packages, directives_ordering

import 'package:firebase_performance/firebase_performance.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'dart:async';

import 'package:http/http.dart';
import 'package:ramadan/services/common/performance/PerformanceMonitoringService.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/exceptions/CustomException.dart';
import 'package:ramadan/utils/servicelocator/ServiceLocator.dart';

FirebasePerformance performance = FirebasePerformance.instance;

final IPerformanceMonitoringService _iPerformanceMonitoringService = ServiceLocator().get<IPerformanceMonitoringService>();

class RestServiceManager {
  static const defaultheader = {'Content-Type': 'application/json'};

  static Future<List<String>> call(String url, String endpoint, Map<String, String>? requestHeader) async {
    Map<String, String> header = new Map<String, String>();
    header.addAll(defaultheader);

    if (requestHeader != null) {
      header.addAll(requestHeader);
    }

    HttpMetric metric = await _iPerformanceMonitoringService.startHttpMetric(endpoint, HttpMethod.Get);

    try {
      Response response;
      Uri uri = Uri.parse(url + endpoint);

      response = await http.get(uri, headers: header);
      await _iPerformanceMonitoringService.stopHttpMetric(endpoint, metric, response);
      switch (response.statusCode) {
        case 200:
          dom.Document ramadanTimesHtmlSource = dom.Document.html(response.body);
          final ramadanTimesTable = ramadanTimesHtmlSource.querySelectorAll('tr[data-dateint] > td');
          return ramadanTimesTable.map((e) => e.innerHtml.trim()).toList();
        default:
          throw CustomException(StringCommonConstant.anErrorOccured);
      }
    } catch (ex) {
      throw CustomException(StringCommonConstant.anErrorOccured);
    }
  }
}
