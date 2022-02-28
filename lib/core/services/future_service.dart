import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shopping/pages/home/home_model.dart';

class FutureService {
  final dio = Dio();

  dynamic _getHttpRequest(String path) async {
    final response = await dio.get<List>(
      path,
      options: Options(
        responseType: ResponseType.json,
      ),
    );
    switch (response.statusCode) {
      case HttpStatus.ok:
        return response.data;
      default:
        return Exception(response.statusMessage);
    }
  }

  Future<List<Product>> getHttpProduct(String path) async {
    final response = await _getHttpRequest(path);
    if (response is List) {
      return response.map((e) => Product.fromJson(e)).toList();      
    } else {
      throw Exception("Failed to make list product");
    }
  }
}
