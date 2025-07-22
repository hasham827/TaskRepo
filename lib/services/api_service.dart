import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/app_const.dart';
import '../constants/app_snack.dart';

class ApiService {
  static const Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  String _getBaseUrl({required bool chat}) => AppConst.baseUrl;

  Map<String, String> _buildHeaders({String? token}) => {
    ..._defaultHeaders,
    if (token != null) 'Authorization': 'Bearer $token',
  };

  void handleError(dynamic error, {http.Response? response}) {
    String message = 'Unexpected error occurred.';

    if (response != null && response.body.isNotEmpty) {
      try {
        final errorData = json.decode(response.body);
        debugPrint('HTTP Error: $errorData');

        if (errorData['errors'] is Map<String, dynamic>) {
          final errors = errorData['errors'] as Map<String, dynamic>;
          final firstError = errors.values.first;
          message = (firstError is List && firstError.isNotEmpty)
              ? firstError.first.toString()
              : 'Validation error';
        } else if (errorData['message'] != null) {
          message = errorData['message'].toString();
        }
      } catch (e) {
        debugPrint('Error parsing response: $e');
        message = 'Failed to parse error response';
      }
    } else {
      debugPrint('Unexpected error: $error');
      message = 'Something went wrong: $error';
    }

    showSnack(message);
  }

  Future<http.Response?> _makeRequest({
    required String method,
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    String? token,
    bool chat = false,
  }) async {
    try {
      final url = Uri.parse(_getBaseUrl(chat: chat) + endpoint)
          .replace(queryParameters: queryParameters);
      final headers = _buildHeaders(token: token);
      final encodedData = data != null ? json.encode(data) : null;
      debugPrint('$method request to $url${data != null ? ':\n$encodedData' : ''}');

      http.Response response;
      switch (method.toUpperCase()) {
        case 'GET':
          response = await http.get(url, headers: headers);
          break;
        case 'POST':
          response = await http.post(url, headers: headers, body: encodedData);
          break;
        case 'PUT':
          response = await http.put(url, headers: headers, body: encodedData);
          break;
        case 'DELETE':
          response = await http.delete(url, headers: headers);
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          (method == 'DELETE' && response.statusCode == 204)) {
        debugPrint('✅ $method response: ${response.body}');
        return response;
      } else {
        handleError(Exception('HTTP ${response.statusCode}'), response: response);
        return null;
      }
    } catch (error) {
      debugPrint('Request failed: $error');
      handleError(error);
      return null;
    }
  }

  Future<http.Response?> getRequest({
    required String endpoint,
    String? token,
    Map<String, dynamic>? queryParameters,
    bool chat = false,
  }) => _makeRequest(
    method: 'GET',
    endpoint: endpoint,
    queryParameters: queryParameters,
    token: token,
    chat: chat,
  );

  Future<http.Response?> postRequest({
    required String endpoint,
    required Map<String, dynamic> data,
    String? token,
    bool chat = false,
  }) => _makeRequest(
    method: 'POST',
    endpoint: endpoint,
    data: data,
    token: token,
    chat: chat,
  );

  Future<http.Response?> putRequest({
    required String endpoint,
    required Map<String, dynamic> data,
    String? token,
    bool chat = false,
  }) => _makeRequest(
    method: 'PUT',
    endpoint: endpoint,
    data: data,
    token: token,
    chat: chat,
  );

  Future<http.Response?> deleteRequest({
    required String endpoint,
    required String token,
    Map<String, dynamic>? queryParameters,
    bool chat = false,
  }) => _makeRequest(
    method: 'DELETE',
    endpoint: endpoint,
    queryParameters: queryParameters,
    token: token,
    chat: chat,
  );
}