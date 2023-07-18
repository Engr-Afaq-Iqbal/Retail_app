import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../Controllers/exception_controller.dart';
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

  static String exceptionFormat(url, code, res) =>
      'EndPoint => $url\nStatus Code => $code\nResponse => $res';

  static Future<String?> getMethod({required String feedUrl}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppStorage.getUserToken()?.accessToken}'
    };
    var request =
        http.Request('GET', Uri.parse('${AppConfig.baseUrl}$feedUrl'));

    request.headers.addAll(headers);

    return await request.send().then((http.StreamedResponse response) async {
      String result = await response.stream.bytesToString();
      logger.i(exceptionFormat(request.url, response.statusCode, result));
      if (response.statusCode == 200) {
        return result;
      }

      await ExceptionController().exceptionAlert(
        resBody: result,
        exceptionFormat:
            exceptionFormat(request.url, response.statusCode, result),
      );
      return null;
    }).onError((error, stackTrace) async {
      print('Error => $error');
      logger.e('StackTrace $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: 'Error: $error\n'
            'ApiService -> postMethod\n'
            'EndPoint => $feedUrl\n'
            'StackTrace => $stackTrace',
      );
      return null;
    });
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
      logger.i(exceptionFormat(request.url, response.statusCode, result));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return result;
      }

      await ExceptionController().exceptionAlert(
        resBody: result,
        exceptionFormat:
            exceptionFormat(request.url, response.statusCode, result),
      );
      return null;
    }).onError((error, stackTrace) async {
      print('Error => $error');
      logger.e('StackTrace $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: 'Error: $error\n'
            'ApiService -> postMethod\n'
            'EndPoint => $feedUrl\n'
            'StackTrace => $stackTrace',
      );
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
      logger.i(exceptionFormat(request.url, response.statusCode, resBody));
      // logger.d(
      //     'Submitted Fields => \nAPI Do => $feedUrl\nStatus Code => ${response.statusCode}\nResponse => $resBody');
      final jd = json.decode(resBody);
      logger.d('Decoded Response => $jd');
      if (returnAnyResponse) return resBody;
      if (response.statusCode == 200) {
        return resBody;
      } else {
        await ExceptionController().exceptionAlert(
          resBody: resBody,
          exceptionFormat:
              exceptionFormat(request.url, response.statusCode, resBody),
        );
        return null;
      }
    } catch (error) {
      print('Error => $error');
      logger.e(
          'Error: ApiService -> postMultiPartMethod -> API Do = $feedUrl, Error => $error');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat:
            'Error: ApiService -> postMultiPartMethod -> API Do = $feedUrl, Error => $error',
      );
      //AppConst.errorOccurAlert();
      return null;
    }
  }
}
