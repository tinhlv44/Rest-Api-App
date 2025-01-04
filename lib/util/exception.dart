import 'package:dio/dio.dart';

class ApiException implements Exception {
  int? code;
  String? message;
  Response<dynamic>? response;
  ApiException(this.code, this.message, {this.response}) {
    if (code != 400) {
      return;
    }
    if (message == 'Failed to authenticate.') {
      message = 'passworld or username is incorrect';
    }
    if (message == 'Failed to create record.') {
      if (response?.data['data']['username'] != null) {
        if (response?.data['data']['username']['message'] ==
            'The username is invalid or already in use.') {
          message = 'username is already in use';
        }
      }
      if (response?.data['data']['email'] != null) {
        if (response?.data['data']['email']['message'] ==
            'The email is invalid or already in use.') {
          message = 'email is already in use';
        }
      }
    }
  }
}

// Định nghĩa lớp abstract để làm cha
abstract class ApiTodosException implements Exception {
  int? code;
  String? message;
  Response<dynamic>? response;

  ApiTodosException(this.code, this.message, {this.response});

  @override
  String toString() {
    return 'ApiTodosException: code=$code, message=$message, response=${response?.data}';
  }
}

class GetApiTodosException extends ApiTodosException {
  GetApiTodosException(super.code, super.message, {super.response}) {
    if (super.code == 400) {
      message = 'Lỗi server';
    }
    if (super.code == 429) {
      super.message = 'Lỗi nhiều request';
    }
  }
}

class PostApiTodosException extends ApiTodosException {
  PostApiTodosException(super.code, super.message, {super.response}) {
    if (super.code == 400) {
      message = 'Lỗi server';
    }
    if (super.code == 429) {
      super.message = 'Lỗi nhiều request';
    }
  }
}

class GetByIdApiTodosException extends ApiTodosException {
  GetByIdApiTodosException(super.code, super.message, {super.response}) {
    if (super.code == 400) {
      message = 'Lỗi server';
    }
    if (super.code == 404) {
      message = 'Id k tìm thấy';
    }
    if (super.code == 429) {
      super.message = 'Lỗi nhiều request';
    }
  }
}
