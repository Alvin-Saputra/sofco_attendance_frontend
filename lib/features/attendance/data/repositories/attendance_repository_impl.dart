import 'dart:io';

import 'package:attendance_frontend/core/error/exception.dart';
import 'package:attendance_frontend/core/utils/api_result.dart';
import 'package:attendance_frontend/features/attendance/data/datasources/attendance_datasources.dart';
import 'package:attendance_frontend/features/attendance/data/models/check_attendance_response.dart';
import 'package:attendance_frontend/features/attendance/data/models/create_attendance_response.dart';
import 'package:attendance_frontend/features/attendance/data/models/fetch_attendance_response.dart';
import 'package:attendance_frontend/features/attendance/domain/repositories/attendance_repository.dart';
import 'package:attendance_frontend/features/auth/data/datasources/local/auth_local_datasources.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceDatasources attendanceDatasource;
  final AuthLocalDatasources authLocalDatasource;
  AttendanceRepositoryImpl(this.attendanceDatasource, this.authLocalDatasource);
  @override
  Future<ApiResult<FetchAttendanceResponse>> fetchAttendance() async {
    try {
      final token = await authLocalDatasource.getToken();
      final userId = await authLocalDatasource.getUserId();
      if (token == null || userId == null)
        return Error('Token or userId is null');
      final response = await attendanceDatasource.fetchAttendance(
        userId,
        token,
      );
      return Success(response);
    } on ServerException catch (e){
      if(e.statusCode == 401){
        return Error ("Session anda telah berakhir. Silahkan Login Kembali");
      }
      else if (e.statusCode == 500){
        return Error('Server sedang bermasalah. Mohon coba lagi nanti');
      }
      return Error('Gagal mengambil data absensi');
    } on NetworkException{
      return Error('Tidak ada koneksi internet. Silakan periksa jaringan anda');
    } on TimeoutCustomException{
      return Error('Koneksi terputus karena terlalu lama. Coba lagi');
    }
    catch (e) {
      return Error('Terjadi kesalahan tidak terduga');
    }
  }

  @override
  Future<ApiResult<CreateAttendanceResponse>> createAttendance({
    required String date,
    required String time,
    required File image,
  }) async {
    try {
      final token = await authLocalDatasource.getToken();
      final userId = await authLocalDatasource.getUserId();
      if (token == null || userId == null)
        return Error('Token or userId is null');
        
      final response = await attendanceDatasource.createAttendance(
        userId: userId,
        token: token,
        date: date,
        time: time,
        image: image,
      );
      return Success(response);
    } on ServerException catch (e){
      if(e.statusCode == 401){
        return Error ("Session anda telah berakhir. Silahkan Login Kembali");
      }
      else if (e.statusCode == 500){
        return Error('Server sedang bermasalah. Mohon coba lagi nanti');
      }
      return Error('Gagal menyimpan data absensi');
    } on NetworkException{
      return Error('Tidak ada koneksi internet. Silakan periksa jaringan anda');
    } on TimeoutCustomException{
      return Error('Koneksi terputus karena terlalu lama. Coba lagi');
    }
    catch (e) {
      return Error('Terjadi kesalahan tidak terduga');
    }
  }

  @override
  Future<ApiResult<CheckAttendanceResponse>> checkAttendance(String date) async {
   try {
      final token = await authLocalDatasource.getToken();
      final userId = await authLocalDatasource.getUserId();
      if (token == null || userId == null)
        return Error('Token or userId is null');
      final response = await attendanceDatasource.checkAttendance(
        userId,
        token,
        date
      );
      return Success(response);
    } on ServerException catch (e){
      if(e.statusCode == 401){
        return Error ("Session anda telah berakhir. Silahkan Login Kembali");
      }
      else if (e.statusCode == 500){
        return Error('Server sedang bermasalah. Mohon coba lagi nanti');
      }
      return Error('Gagal mengambil data absensi');
    } on NetworkException{
      return Error('Tidak ada koneksi internet. Silakan periksa jaringan anda');
    } on TimeoutCustomException{
      return Error('Koneksi terputus karena terlalu lama. Coba lagi');
    }
    catch (e) {
      return Error('Terjadi kesalahan tidak terduga');
    }
  }
}
