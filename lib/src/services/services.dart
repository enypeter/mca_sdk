import 'dart:convert';
import 'dart:io';
// import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class WebServices {
  static const String _initialiseSdkUrl =
      'https://staging.api.mycover.ai/v1/sdk/initialize';

  static initialiseSdk({
    required String userId,
    required String productId,
  }) async {
    var data = {
      "client_id": userId,
      "product_id": productId,
    };

    return await _initialisePostRequest(url: _initialiseSdkUrl, data: data);
  }

  static _makePostRequest({apiUrl, data, token}) async {
    final uri = Uri.parse(apiUrl);
    final jsonString = json.encode(data);
    print(data);    print(apiUrl);


    var headers;
    if (token != null) {
      headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
    } else {
      headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
    }
    return await http.post(uri, body: jsonString, headers: headers);
  }

  static _initialisePostRequest(
      {required Map<String, dynamic> data, required String url, token}) async {
    // if (await _checkConnectivity()) {
    try {
      var response =
      await _makePostRequest(apiUrl: url, data: data, token: token);
      var body = jsonDecode(response.body);
      if (_isRequestSuccessful(response.statusCode)) {
        if (body['ResponseCode'] != 100) {
          return body['ResponseMessage'];
        } else {
          return body;
        }
      } else {
        return _handleError(response);
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
    // } else {
    //   return 'Check your internet connection';
    // }
  }

  static _handleError(http.Response response) {
    switch (response.statusCode) {
      case 400:
        throw (jsonDecode(response.body)['responseText']);

      case 401:
        throw 'Unauthorized request - ${jsonDecode(response.body)['responseText']}';

      case 403:
        throw 'Forbidden Error - ${jsonDecode(response.body)['responseText']}';
      case 404:
        throw 'Not Found - ${jsonDecode(response.body)['responseText']}';

      case 422:
        throw 'Unable to process - ${jsonDecode(response.body)['responseText']}';

      case 500:
        throw 'Server error - ${jsonDecode(response.body)['responseText']}';
      default:
        throw 'Error occurred with code : $response';
    }
  }

  static _isRequestSuccessful(int? statusCode) {
    return statusCode! >= 200 && statusCode < 300;
  }

  static final Duration _CONNECTIVITY_TIMEOUT = Duration(seconds: 5);

// static Future<bool> _checkConnectivity() async {
//   try {
//     ConnectivityResult conn = await Connectivity().checkConnectivity();
//     if (conn != ConnectivityResult.wifi &&
//         conn != ConnectivityResult.mobile) {
//       return false;
//     }
//     final result = await InternetAddress.lookup('google.com')
//         .timeout(_CONNECTIVITY_TIMEOUT);
//     if (result.isNotEmpty && result.first.rawAddress.isNotEmpty == true) {
//       return true;
//     }
//   } catch (e) {
//     return false;
//   }
//   return false;
// }
}
