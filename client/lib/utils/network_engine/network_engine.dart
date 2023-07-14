import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:whisper/utils/storage/storage.dart';

class NetworkEngine {
  static const String _baseURL = "https://whisper-api-7et7.onrender.com";

  // ------------------------- Auth Routes --------------------------------
  static const String googleSignInRoute = "/api/v0/auth/google-sign-in";

  // ------------------------- Search Routes --------------------------------
  static const String searchRoute = "/api/v0/search";

  static Dio getDio({
    Map<String, dynamic>? headers,
    String? baseURL,
    bool onlyAddInterceptors = false,
    bool addAuthToken = true,
    bool saveCredentials = true,
    void Function(Response)? onResponse,
  }) {
    Dio dio;
    if (onlyAddInterceptors) {
      dio = Dio();
    } else {
      Map<String, dynamic> _headers = {};
      _headers = headers ?? {};
      _headers['Content-Type'] = 'application/json';
      _headers['Authorization'] =
          StorageHandler.instance.get(StoredValues.token.name);

      dio = Dio(
        BaseOptions(
          headers: _headers,
          baseUrl: baseURL ?? _baseURL,
        ),
      );
    }
    if (kDebugMode) {
      dio.interceptors.add(
        InterceptorsWrapper(onError: (error, errorInterceptorHandler) {
          debugPrint('''
        ******************************************************************************************************

        ${error.message} || ${error.response}

        ******************************************************************************************************
        ''');
          return errorInterceptorHandler.next(error);
        }, onRequest: (request, requestInterceptorHandler) {
          debugPrint('''
        ******************************************************************************************************

        ${request.method} || ${request.baseUrl}${request.path} ||| ${request.data}

        ******************************************************************************************************
        ''');
          return requestInterceptorHandler.next(request);
        }, onResponse: (response, responseInterceptorHandler) {
          if (onResponse != null) {
            onResponse(response);
          }
          if (saveCredentials &&
              response.data?[StoredValues.token.name] != null) {
            StorageHandler.instance.setString(StoredValues.token.name,
                response.data?[StoredValues.token.name]);
          }
          debugPrint('''
          -******************************************************************************************************
          ${response.statusMessage} || ${response.statusCode} |||| ${response.data}
          --******************************************************************************************************
          ''');

          return responseInterceptorHandler.next(response);
        }),
      );
    }
    return dio;
  }
}
