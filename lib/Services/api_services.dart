import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../Config/const.dart';
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

  static String methodExceptionFormat(method, url, error, stackTrace) =>
      '$method, EndPoint: $url\nError: $error\nStackTrace: $stackTrace';

  static Future<String?> postMultiPartQuery({
    required String feedUrl,
    Map<String, String>? fields,
    Map<String, String>? files,
    bool returnAnyResponse = false,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
        //  "Content-type": "application/json",
        'Authorization': 'Bearer ${AppStorage.getUserToken()?.accessToken}'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('${AppConfig.baseUrl}$feedUrl'));
      if (fields != null) {
        request.fields.addAll(fields);
      }
      if (files != null) {
        files.forEach((key, value) async {
          request.files.add(
            await http.MultipartFile.fromPath(
              key,
              value,
              filename: value.split("/").last,
            ),
          );
        });
      }
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      String resBody = await response.stream.bytesToString();
      logger.d(
          'Submitted Fields => \nAPI Do => $feedUrl\nStatus Code => ${response.statusCode}\nResponse => $resBody');
      final jd = json.decode(resBody);
      logger.d('Decoded Response => $jd');
      if (returnAnyResponse) return resBody;
      if (response.statusCode == 200) {
        return resBody;
      } else {
        return null;
      }
    } catch (error) {
      logger.e(
          'Error: ApiService -> postMultiPartMethod -> API Do = $feedUrl, Error => $error');
      //AppConst.errorOccurAlert();
      return null;
    }
  }
}
