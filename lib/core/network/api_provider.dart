import 'package:dio/dio.dart';

abstract class APIProvider{

  Future<Response> get({
    String? baseUrl,
    required String endPoint,
  });
}