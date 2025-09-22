import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class ApiCaller {

 static final Logger _logger = Logger();

 static Future<ApiResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);

      _logRequest(url);
      Response response = await get(uri);
      _logResponse(url, response);


      final int statusCode = response.statusCode;


      if (statusCode == 200 ){
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
            isSuccess: true,
            responseCode: statusCode,
            responseData: decodedData
        );
      }else{
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
            isSuccess: false,
            responseCode: statusCode,
            responseData: decodedData,
          errorMessage:decodedData.responseData['data']
        );
      }
    } on Exception catch (e) {
      return ApiResponse(
          isSuccess: false,
          responseCode: -1,
          responseData:null,
        errorMessage: e.toString()
      );
    }
  }
 static Future<ApiResponse> postRequest({required String url,Map<String,dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);

      _logRequest(url,body: body);
      Response response = await post(
        headers: {'contant-type': 'application/json'},
          uri,body: jsonEncode(body)
      );
      _logResponse(url, response);


      final int statusCode = response.statusCode;


      if (statusCode == 200 || statusCode == 201){
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
            isSuccess: true,
            responseCode: statusCode,
            responseData: decodedData
        );
      }else{
        final decodedData = jsonDecode(response.body);
        return ApiResponse(
            isSuccess: false,
            responseCode: statusCode,
            responseData: decodedData,
            errorMessage:decodedData.responseData['data']
        );
      }
    } on Exception catch (e) {
      return ApiResponse(
          isSuccess: false,
          responseCode: -1,
          responseData:null,
        errorMessage: e.toString()
      );
    }
  }
  static void _logRequest(String url, {Map<String, dynamic>? body}){
    _logger.i('URL => $url\n'
        'RequestBody:$body'
    );
  }

 static void _logResponse(String url,Response response){
   _logger.i('URL => $url\n'
       'Status Code : ${response.statusCode}\n'
       'Body: ${response.body}'
   );
 }
}

class ApiResponse {
  final bool isSuccess;
  final int responseCode;
  final dynamic responseData;
  final String? errorMessage;

  ApiResponse(
      {required this.isSuccess,
      required this.responseCode,
      required this.responseData,
      this.errorMessage = 'Something went wrong',
      });
}
