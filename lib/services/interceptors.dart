import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends Interceptor {
  Logger logger =
      Logger(printer: PrettyPrinter(methodCount: 0, printTime: true));

  @override
  // ignore: deprecated_member_use
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request ==> $requestPath'); //Error log
    logger.d('Error type: ${err.error} \n'
        'Error String: ${err.toString()} \n'
        'Sent headers: ${options.headers} \n'
        'Sent body: ${options.data} \n'
        'More info: ${err.response} \n'
        'Error message: ${err.message}'); //Debug log
    handler.next(err); //Continue with the Error
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    logger.i('${options.method} request ==> $requestPath'); //Info log
    handler.next(options); // continue with the Request
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('STATUSCODE: ${response.statusCode} \n '
        'STATUSMESSAGE: ${response.statusMessage} \n'
        'HEADERS: ${response.headers} \n'
        'Data: ${response.data}'); // Debug log
    handler.next(response); // continue with the Response
  }
}

/// This interceptor intercepts GET request and add "Authorization" header
/// and then, send it to the [API]
class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // adds the access-token with the header
    // add content-typr to headers
    options.headers["Authorization"] = "myTempDevice";
    handler.next(options); // continue with the request
  }

// If i want to set api_key for just particular request method
// then i can use this method and check the method type

// bool _needAuthorizationHeader(RequestOptions options) {
//   if (options.method == 'GET') {
//     return true;
//   }
//   return false;
// }
}
