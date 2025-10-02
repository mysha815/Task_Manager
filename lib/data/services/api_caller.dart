import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:task_manager/ui/controller/auth_controller.dart';

import '../../app.dart';
import '../../ui/Screens/login_screen.dart';

class ApiCaller {
  static final Logger _logger = Logger();

  static Future<ApiResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);

      _logRequest(url);
      Response response = await get(uri, headers: {
        'content-type': 'application/json',
        'token': AuthController.accessToken ?? ''
      });
      _logResponse(url, response);

      final int statusCode = response.statusCode;

      final decodedData = jsonDecode(response.body);

      if (statusCode == 200) {
        return ApiResponse(
          isSuccess: true,
          responseCode: statusCode,
          responseData: decodedData,
        );
      } else if (statusCode == 401) {
        await _moveToLogin();
        return ApiResponse(
          isSuccess: false,
          responseCode: statusCode,
          errorMessage: 'Un-authorize',
          responseData: null,
        );
      } else {
        return ApiResponse(
          isSuccess: false,
          responseCode: statusCode,
          responseData: decodedData,
          errorMessage:
              decodedData['data']?.toString() ?? 'Something went wrong',
        );
      }
    } on Exception catch (e) {
      return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<ApiResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);

      _logRequest(url, body: body);
      Response response = await post(
        uri,
        headers: {
          'content-type': 'application/json',
          'token': AuthController.accessToken ?? ''
        }, // spelling ঠিক করা হলো ✅
        body: jsonEncode(body),
      );
      _logResponse(url, response);

      final int statusCode = response.statusCode;

      final decodedData = jsonDecode(response.body);

      if (statusCode == 200 || statusCode == 201) {
        return ApiResponse(
          isSuccess: true,
          responseCode: statusCode,
          responseData: decodedData,
        );
      } else if (statusCode == 401) {
        await _moveToLogin();
        return ApiResponse(
          isSuccess: false,
          responseCode: statusCode,
          errorMessage: 'Un-authorize',
          responseData: null,
        );
      } else {
        return ApiResponse(
          isSuccess: false,
          responseCode: statusCode,
          responseData: decodedData,
          errorMessage:
              decodedData['data']?.toString() ?? 'Something went wrong',
        );
      }
    } on Exception catch (e) {
      return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

  static void _logRequest(String url, {Map<String, dynamic>? body}) {
    _logger.i('URL => $url\nRequestBody:$body');
  }

  static void _logResponse(String url, Response response) {
    _logger.i(
        'URL => $url\nStatus Code : ${response.statusCode}\nBody: ${response.body}');
  }

  static Future<void> _moveToLogin() async {
    await AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(TaskManagerApp.navigator.currentContext!,
        LoginScreen.name, (predicate) => false);
  }
}

class ApiResponse {
  final bool isSuccess;
  final int responseCode;
  final dynamic responseData;
  final String? errorMessage;

  ApiResponse({
    required this.isSuccess,
    required this.responseCode,
    required this.responseData,
    this.errorMessage = 'Something went wrong',
  });
}
