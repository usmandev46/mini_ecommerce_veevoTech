import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com'));

  Future<String> login(String username, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        "username": username,
        "password": password,
      });

      if (response.statusCode == 200 && response.data['token'] != null) {
        return response.data['token'];
      } else {
        return '';
      }
    } on DioException catch (e) {
      if (e.response?.data != null && e.response!.data is Map && e.response!.data['message'] != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception('Login failed. Please try again.');
      }
    }
  }
}
