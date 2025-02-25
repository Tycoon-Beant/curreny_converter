import 'package:dio/dio.dart';

class DioSingleton {
  static DioSingleton? _dioSingleton;
  DioSingleton._internal() {
    dio = Dio(
      BaseOptions(
        // baseUrl: baseUrl,
        connectTimeout: Duration(minutes: 1),
        sendTimeout: Duration(minutes: 1),
        receiveTimeout: Duration(minutes: 1),
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    // dio.interceptors.add(TokenService.instance.interceptor);
    // dio.interceptors.add(LogInterceptor());
  }
  late Dio dio;

  static DioSingleton get instance {
    if (_dioSingleton == null) {
      _dioSingleton = DioSingleton._internal();
    }
    return _dioSingleton!;
  }
}
