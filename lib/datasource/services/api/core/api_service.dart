// ignore_for_file: unused_import, depend_on_referenced_packages, unnecessary_brace_in_string_interps, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base/core/error/error.dart';
import 'package:flutter_base/datasource/services/api/core/core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class APIService<T> {
  static final shared = APIService();

  final client = http.Client();

  generateHeader() async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    return headers;
  }

  // Map<String, dynamic> generateUrlParams() async {

  //   var param = {
  //     "api_key": "${apiKey}",
  //     "language": "en-US",
  //   };

  //   return param;
  // }

  Future<APIBaseOutput> requestGet(APIBaseInput input) async {
    await dotenv.load(fileName: ".env");
    final apiKey = dotenv.env['API_KEY'];

    final queryParameters = {
      "api_key": "${apiKey}",
      "language": "en-US",
    };
    try {
      final headers = await generateHeader();
      if (input.headers != null) {
        input.headers?.addAll(headers);
      } else {
        input.headers = headers;
      }
      final uri =
          Uri.parse(input.url).replace(queryParameters: queryParameters);
      if (kDebugMode) {
        print('===REQUEST===');
        print('URL: ${input.url}');
        print('Method: GET');
        print('Body: ${input.body}');
        print('Headers: ${input.headers}');
      }
      final response = await client.get(
        uri,
      );
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      if (kDebugMode) {
        print('===RESPONSE===');
        print('Status code: ${response.statusCode}');
        print('Response: ${json}');
      }
      return APIBaseOutput(json);
    } catch (error) {
      if (kDebugMode) {
        print('Error: ${error.toString()}');
      }
      throw ServerException('API: GET FAILURE!');
    }
  }

  Future<APIBaseOutput> requestPost(APIBaseInput input) async {
    try {
      final headers = await generateHeader();
      if (input.headers != null) {
        input.headers?.addAll(headers);
      } else {
        input.headers = headers;
      }
      final jsonBody = input.body != null ? jsonEncode(input.body) : null;
      if (kDebugMode) {
        print('===REQUEST===');
        print('URL: ${input.url}');
        print('Method: POST');
        print('Body: $jsonBody');
        print('Headers: ${input.headers}');
      }
      final response = await client.post(Uri.parse(input.url),
          headers: input.headers, body: input.body);
      Map<String, Object> json = response.body as Map<String, Object>;
      if (kDebugMode) {
        print('===RESPONSE===');
        print('Status code: ${response.statusCode}');
        print('ResponseL ${json}');
      }
      return APIBaseOutput(json);
    } catch (error) {
      if (kDebugMode) {
        print('Error: ${error.toString()}');
      }
      throw ServerException('API: POST FAILURE!');
    }
  }

  Future<APIBaseOutput> upload(APIBaseInput input, String filePath) async {
    try {
      final headers = await generateHeader();
      if (input.headers != null) {
        input.headers?.addAll(headers);
      } else {
        input.headers = headers;
      }
      if (kDebugMode) {
        print('===UPLOAD===');
        print('URL: ${input.url}');
        print('File path: $filePath');
      }

      var request = http.MultipartRequest('POST', Uri.parse(input.url));
      request.files.add(await http.MultipartFile.fromPath('avatar', filePath));
      request.headers['Authorization'] = headers['Authorization'];
      request.headers['Content-Type'] = 'multipart/form-data';
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      Map<String, Object> json = response.body as Map<String, Object>;
      if (kDebugMode) {
        print('===RESPONSE===');
        print('Status code: ${response.statusCode}');
        print('Response: ${json}');
      }
      return APIBaseOutput(json);
    } catch (error) {
      if (kDebugMode) {
        print('Error: ${error.toString()}');
      }
      throw ServerException('API: POST FAILURE!');
    }
  }
}
