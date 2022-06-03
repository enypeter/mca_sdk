 import 'dart:convert';
import 'dart:io';
 import 'package:http/http.dart' as http;

  makePostRequest({apiUrl, data, token}) async {
  final uri = Uri.parse(apiUrl);
  final jsonString = json.encode(data);
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