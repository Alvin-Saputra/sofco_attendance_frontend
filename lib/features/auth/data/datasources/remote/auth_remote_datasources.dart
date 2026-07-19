import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:attendance_frontend/core/error/exception.dart';
import 'package:attendance_frontend/features/auth/data/models/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthRemoteDatasources {
  static final String _baseUrl = dotenv.env['BASE_URL'] ?? 'http://10.0.2.2:3000';

  Future<LoginResponse> login(String username, String password) async {
    final url = Uri.parse('$_baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'username': username, 'password': password}),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> decodedJson = json.decode(response.body);
        return LoginResponse.fromJson(decodedJson);
      } else {
        print("Ini adalah status code: ${response.statusCode}");
        print("Ini adalah status code: ${response.body}");
        throw ServerException(response.statusCode, response.body);
      }
    } on SocketException {
      throw NetworkException();
    } on TimeoutException {
      throw TimeoutCustomException();
    } catch (e, stackTrace) {
      print("Error Dari datasource: $e");
      print("Titik Lokasi (Stack Trace):\n$stackTrace" );
      rethrow;
    }
  }
}
