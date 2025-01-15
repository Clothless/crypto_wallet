import 'dart:convert';

import 'package:crypto_wallet/core/const/endpoints.dart';
import 'package:crypto_wallet/services/interceptors.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

class DioClient {
  late Dio dio;

  DioClient() {
    dio = Dio();

    dio.options = BaseOptions(
      validateStatus: (statusCode) {
        if (statusCode == null) {
          return false;
        } else {
          return true;
        }
      },
      baseUrl: Endpoints.url,
      followRedirects: false,
      sendTimeout: Endpoints.sendTimeout,
      contentType: Headers.jsonContentType,
      connectTimeout: Endpoints.connectTimeout,
      receiveTimeout: Endpoints.receiveTimeout,
      responseType: ResponseType.json,
      responseDecoder: (List<int> responseBytes, RequestOptions options,
          ResponseBody responseBody) async {
        final dynamic response =
            utf8.decode(responseBytes, allowMalformed: true);
        if (response == null ||
            response == "" ||
            response[0] == "" ||
            response[0] != "{") return response;
        final dynamic responseJson = jsonDecode(response);
        return json.encode(responseJson).replaceAll("�", "e");
      },
      preserveHeaderCase: true,
    );

    dio.interceptors.addAll([AuthorizationInterceptor(), LoggerInterceptor()]);
  }

  // GET METHOD
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelRequestToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelRequestToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // POST METHOD
  Future<Response> post(
    String url, {
    String? token,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelRequestToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await dio.post(
        url,
        data: data,
        options: options,
        cancelToken: cancelRequestToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT METHOD
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelRequestToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelRequestToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //PATCH method
  Future<Response> patch(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelRequestToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelRequestToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE METHOD
  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelRequestToken,
  }) async {
    try {
      final Response response = await dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelRequestToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
