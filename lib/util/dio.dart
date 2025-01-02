import 'package:dio/dio.dart';

class DioProvider {
  static Dio createDioWithoutHeader() {
    Dio dio = Dio(BaseOptions(
      baseUrl: 'https://api.nstack.in/v1/todos',
    ));

    return dio;
  }
}
