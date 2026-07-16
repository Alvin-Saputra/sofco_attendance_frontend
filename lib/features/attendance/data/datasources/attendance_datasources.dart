import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:attendance_frontend/features/attendance/data/models/fetch_attendance_response.dart';
import 'package:http/http.dart' as http;
class AttendanceDatasources {
  static const String _baseUrl = 'http://localhost:3000';

  Future<FetchAttendanceResponse> fetchAttendance(int userId) async{
    

    final url = Uri.parse('$_baseUrl/attendance?userId=$userId');

    try{
      final response = await http.get(url, headers: {
          'Accept': 'application/json',
        },);

        if(response.statusCode == 200){
          final Map<String, dynamic> decodedJson = json.decode(response.body);
          return FetchAttendanceResponse.fromJson(decodedJson);
        } else {
          throw Exception("Failed to load data. Status: ${response.statusCode}, Body: ${response.body}");
        }
    } on SocketException {
      throw Exception('Tidak ada koneksi internet. Silakan periksa jaringan Anda.');
    } on TimeoutException {
      throw Exception('Koneksi terputus karena terlalu lama (Timeout).');
    } on FormatException {
      throw Exception('Format data dari server tidak valid (Gagal parse JSON).');
    } on http.ClientException catch (e) {
      throw Exception('Terjadi kesalahan pada client HTTP: ${e.message}');
    } catch (e) {
      throw Exception('Terjadi kesalahan tak terduga: $e');
    }
  }
}