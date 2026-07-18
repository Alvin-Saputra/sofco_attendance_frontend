import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:attendance_frontend/core/error/exception.dart';
import 'package:attendance_frontend/core/utils/date_parser.dart';
import 'package:attendance_frontend/features/attendance/data/models/check_attendance_response.dart';
import 'package:attendance_frontend/features/attendance/data/models/create_attendance_response.dart';
import 'package:attendance_frontend/features/attendance/data/models/fetch_attendance_response.dart';
import 'package:http/http.dart' as http;

class AttendanceDatasources {
  static const String _baseUrl = 'http://10.0.2.2:3000';

  Future<FetchAttendanceResponse> fetchAttendance(
    int userId,
    String token,
  ) async {
    final url = Uri.parse('$_baseUrl/attendance?userId=$userId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedJson = json.decode(response.body);
        return FetchAttendanceResponse.fromJson(decodedJson);
      } else {
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
  Future<CheckAttendanceResponse> checkAttendance(
    int userId,
    String token,
    String date
  ) async {
    final url = Uri.parse('$_baseUrl/attendance/check?userId=$userId&date=$date');

    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedJson = json.decode(response.body);
        return CheckAttendanceResponse.fromJson(decodedJson);
      } else {
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

  Future<CreateAttendanceResponse> createAttendance({
    required int userId,
    required String token,
    required String date,
    required String time,
    required File image,
  }) async {
    final url = Uri.parse('$_baseUrl/attendance');
    var request = http.MultipartRequest('POST', url);

    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    try {
      request.fields['userId'] = userId.toString();
      request.fields['date'] = date;
      request.fields['time'] = time;

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
