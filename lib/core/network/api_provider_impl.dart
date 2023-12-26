import 'package:dio/dio.dart';
import 'package:signify_demo_app/core/network/api_provider.dart';
import '../utilities/endpoints.dart';

class APIProviderImpl implements APIProvider {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrlPath,
      receiveDataWhenStatusError: true,
    ),
  );

  @override
  Future<Response> get({
    String? baseUrl,
    required String endPoint,
    int? timeOut,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = timeOut as Duration?;
    }

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return await dio.get(
      endPoint,
    );
  }
}
