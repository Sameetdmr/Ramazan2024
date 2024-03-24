// ignore_for_file: null_argument_to_non_null_type, unnecessary_new, cascade_invocations, prefer_collection_literals, prefer_final_locals, omit_local_variable_types, depend_on_referenced_packages, directives_ordering

import 'package:firebase_performance/firebase_performance.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'dart:async';

import 'package:http/http.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/exceptions/CustomException.dart';

FirebasePerformance performance = FirebasePerformance.instance;

class RestServiceManager {
  static const defaultheader = {'Content-Type': 'application/json'};

  static Future<List<String>> call(String url, String endpoint, Map<String, String>? requestHeader) async {
    Map<String, String> header = new Map<String, String>();
    header.addAll(defaultheader);

    if (requestHeader != null) {
      header.addAll(requestHeader);
    }

    final Trace trace = performance.newTrace('rest_service_call_trace');
    HttpMetric metric = performance.newHttpMetric(url + endpoint, HttpMethod.Get);
    await trace.start();

    try {
      Response response;
      var uri = Uri.parse(url + endpoint);

      response = await http.get(uri, headers: header);

      switch (response.statusCode) {
        case 200:
          dom.Document ramadanTimesHtmlSource = dom.Document.html(response.body);
          final ramadanTimesTable = ramadanTimesHtmlSource.querySelectorAll('tr[data-dateint] > td');
          metric.httpResponseCode = response.statusCode;
          metric.responsePayloadSize = response.contentLength;
          trace.setMetric(url + endpoint, response.statusCode);
          await trace.stop();
          return ramadanTimesTable.map((e) => e.innerHtml.trim()).toList();
        default:
          metric.httpResponseCode = response.statusCode;
          metric.responsePayloadSize = response.contentLength;
          trace.setMetric(url + endpoint, response.statusCode);
          await trace.stop();
          throw CustomException(StringCommonConstant.anErrorOccured);
      }
    } catch (ex) {
      await trace.stop();
      throw CustomException(StringCommonConstant.anErrorOccured);
    }
  }
}
