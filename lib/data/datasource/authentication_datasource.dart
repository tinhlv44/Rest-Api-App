// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:rest_api_app/util/auth_manager.dart';
import 'package:rest_api_app/util/dio.dart';
import 'package:rest_api_app/util/exception.dart';

abstract class IAuthenticationDatasource {
  Future<void> register(
      String Email, String Password, String Confirmpassword, String name);
  Future<String> login(String Email, String Password);
}

class AuthenticationRemote extends IAuthenticationDatasource {
  final Dio _dio = DioProvider.createDioWithoutHeader();

  @override
  Future<void> register(String Email, String Password, String Confirmpassword,
      String name) async {
    try {
      final response = await _dio.post(
        '',
        data: {
          // 'email': Email,
          // 'username': name,
          // 'password': Password,
          // 'passwordConfirm': Confirmpassword,
          "title": name,
          "description": Password,
          "is_completed": Password == Confirmpassword
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 201) {
        login(Email, Password);
      }
      // ignore: deprecated_member_use
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message'],
          response: ex.response);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }

  @override
  Future<String> login(String Email, String Password) async {
    try {
      final response = await _dio.post(
        '',
        data: {
          // 'identity': Email,
          // 'password': Password,
          "title": Email,
          "description": Password,
          "is_completed": false
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 201) {
        AuthManager.saveId(response.data?['data']['_id']);
        AuthManager.saveToken(response.data?['data']['_id']);
        return response.data?['data']['_id'];
      }
      // ignore: deprecated_member_use
    } on DioError catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Unknow Error: $ex');
    }
    return '';
  }
}
