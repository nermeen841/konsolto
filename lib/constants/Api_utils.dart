import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class NetWorkData {
  Dio dio = Dio();

  String baseUrl = '';

  Future<dynamic> getData({
    String url,
    List<Map<String, dynamic>> headers,
  }) async {
    try {
      var jsonResponse;
      dio.options.baseUrl = baseUrl;

      // ignore: unnecessary_statements
      headers != null ? dio.options.headers = headers[0] : '';

      Response response = await dio.get('$url');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        jsonResponse = json.decode(response.toString());
        if (jsonResponse['success'] == true)
          return jsonResponse;
        else {
          throw jsonResponse['data'];
        }
      } else {
        return response;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.DEFAULT) {
        throw "تعذر الوصول للسيرفر";
      }

      if (e.error is SocketException) {
        throw "لا يوجد اتصال بالانترنت ";
      }
    }
  }

  Future<dynamic> putData(
      {FormData formData, Map<String, dynamic> headers, String url}) async {
    try {
      dio.options.baseUrl = baseUrl;
      headers != null ? dio.options.headers = headers : '';
      Map<String, dynamic> jsonResponse;
      Response response = await dio.put(url, data: formData);
      jsonResponse = response.data;
      print("----------------------");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(jsonResponse);
        if (jsonResponse['success'] == true) {
          return jsonResponse;
        } else {
          print("-----------------");
          throw jsonResponse['data'];
        }
      } else if (response == null) {
        print("-------------------response null");
        return response;
      } else {
        print("-------------------response null2");
        return response;
      }
    } on DioError catch (e) {
      print(e.response);

      if (e.type == DioErrorType.DEFAULT) {
        throw "لا يوجد اتصال بالانترنت ";
      } else {
        throw e.toString();
      }
    }
  }

  Future<dynamic> postData(
      {FormData formData, Map<String, dynamic> headers, String url}) async {
    try {
      dio.options.baseUrl = baseUrl;
      // ignore: unnecessary_statements
      headers != null ? dio.options.headers = headers : '';
      Map<String, dynamic> jsonResponse;
      Response response = await dio.post(url, data: formData);
      jsonResponse = response.data;
      print("----------------------");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print(jsonResponse);
        if (jsonResponse['success'] == true) {
          return jsonResponse;
        } else {
          print("-----------------");
          throw jsonResponse['data'];
        }
      } else if (response == null) {
        print("-------------------response null");
        return response;
      } else {
        print("-------------------response null2");
        return response;
      }
    } on DioError catch (e) {
      print(e.response);

      if (e.type == DioErrorType.DEFAULT) {
        throw "لا يوجد اتصال بالانترنت ";
      } else {
        throw e.toString();
      }
    }
  }
}
