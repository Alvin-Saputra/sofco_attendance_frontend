import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:attendance_frontend/core/utils/date_parser.dart';
import 'package:attendance_frontend/features/attendance/data/models/create_attendance_response.dart';
import 'package:attendance_frontend/features/attendance/data/models/fetch_attendance_response.dart';
import 'package:http/http.dart' as http;

class AttendanceDatasources {
  static const String _baseUrl = 'http://10.0.2.2:3000';

  Future<FetchAttendanceResponse> fetchAttendance(int userId) async {
    final url = Uri.parse('$_baseUrl/attendance?userId=$userId');

    try {
      final response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedJson = json.decode(response.body);
        return FetchAttendanceResponse.fromJson(decodedJson);
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
    } catch (e) {
      throw Exception('Terjadi kesalahan tak terduga: $e');
    }
  }

  Future<CreateAttendanceResponse> createAttendance({
    required int userId,
    required String date,
    required String time,
    required File image,
  }) async {
    final url = Uri.parse('$_baseUrl/attendance');
    var request = http.MultipartRequest('POST', url);

    request.headers.addAll({'Accept': 'application/json'});

    try {
      request.fields['userId'] = userId.toString();
      request.fields['date'] = date;
      request.fields['time'] = time;
      // request.fields['image'] = time;

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          image.path,
          contentType: http.MediaType('image', 'jpeg'),
        ),
      );
      var streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final Map<String, dynamic> decodedJson = json.decode(response.body);
        return CreateAttendanceResponse.fromJson(decodedJson);
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
