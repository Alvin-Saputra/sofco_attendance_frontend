import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:attendance_frontend/features/auth/data/models/login_response.dart';
import 'package:http/http.dart' as http;

class AuthDatasources {
  static const String _baseUrl = 'http://10.0.2.2:3000';

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
        throw Exception(
          "Failed to load data. Status: ${response.statusCode}, Body: ${response.body}",
        );
      }
    } on SocketException {
      throw Exception(
        'Tidak ada koneksi internet. Silakan periksa jaringan Anda.',
      );
    } on TimeoutException {
      throw Exception('Koneksi terputus karena terlalu lama (Timeout).');
    } on FormatException {
      throw Exception(
        'Format data dari server tidak valid (Gagal parse JSON).',
      );
    } on http.ClientException catch (e) {
      throw Exception('Terjadi kesalahan pada client HTTP: ${e.message}');
    } catch (e, stackTrace) {
      print('=== DEBUG ERROR TERTANGKAP ===');
      print('Error Asli: $e');
      print('Titik Lokasi (Stack Trace):\n$stackTrace');
      throw Exception('Terjadi kesalahan tak terduga: $e');
    }
  }
}
