import 'package:dio/dio.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    const apiKey = String.fromEnvironment('API_KEY', defaultValue: '');
    dio = Dio(BaseOptions(
      baseUrl: 'https://api.football-data.org/v4',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'X-Auth-Token': apiKey},
    ));
  }
}
