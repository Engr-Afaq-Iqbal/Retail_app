import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '/Config/app_config.dart';
import '../Config/utils.dart';
import 'storage_services.dart';

class ApiServices {
  // static Future<String?> queryMethod({required String method, required String endPoint}) async {
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer ${AppStorage.getUserToken()?.accessToken}'
  //   };
  //   var request = http.Request(method, Uri.parse('${AppConfig.baseUrl}$endPoint'));
  //
  //   request.headers.addAll(headers);
  //
  // }

  static Future<String?> getMethod({required String feedUrl}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppStorage.getUserToken()?.accessToken}'
    };
    var request =
        http.Request('GET', Uri.parse('${AppConfig.baseUrl}$feedUrl'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String result = await response.stream.bytesToString();
    logger.i(
        'EndPoint => ${request.url}\nStatus Code => ${response.statusCode}\nResponse => $result');
    if (response.statusCode == 200) {
      return result;
    }
    return null;
  }

  static Future<String?> postMethod(
      {required feedUrl, Map<String, String>? fields}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppStorage.getUserToken()?.accessToken}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${AppConfig.baseUrl}$feedUrl'));
    if (fields != null) {
      request.fields.addAll(fields);
      logger.i(request.fields);
    }

    request.headers.addAll(headers);

    return await request.send().then((http.StreamedResponse response) async {
      String result = await response.stream.bytesToString();
      logger.i(
          'EndPoint => ${request.url}\nStatus Code => ${response.statusCode}\nResponse => $result');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return result;
      } else {
        final jd = jsonDecode(result);

        showToast(jd["message"]);

        return null;
      }
    }).onError((error, stackTrace) {
      log('Error => $error');
      logger.e('StackTrace => $stackTrace');
      return null;
    });
  }

  // static Future<String?> putMethod({required feedUrl, Map<String, String>? fields}) async {
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer ${AppStorage.getUserToken()?.accessToken}'
  //   };
  //   var request = http.MultipartRequest('PUT', Uri.parse('${AppConfig.baseUrl}$feedUrl'));
  //   if (fields != null) request.fields.addAll(fields);
  //
  //   request.headers.addAll(headers);
  //
  //   return await request.send().then((http.StreamedResponse response) async {
  //     String result = await response.stream.bytesToString();
  //     logger.i(
  //         'EndPoint => ${request.url}\nStatus Code => ${response.statusCode}\nResponse => $result');
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return result;
  //     } else {
  //       final jd = jsonDecode(result);
  //
  //       showToast(jd["message"]);
  //
  //       return null;
  //     }
  //   }).onError((error, stackTrace) {
  //     log('Error => $error');
  //     logger.e('StackTrace => $stackTrace');
  //     return null;
  //   });
  // }
}
