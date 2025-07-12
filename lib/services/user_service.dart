import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com'));

  Future<Response> getUser(int id) async {
    return await _dio.get('/users/$id');
  }
}
