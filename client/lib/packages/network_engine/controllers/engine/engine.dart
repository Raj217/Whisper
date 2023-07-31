part of network_engine;

class NetworkEngine {
  static const String _baseURL = "https://whisper-api-7et7.onrender.com";

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
      if (!_headers.containsKey('Content-Type')) {
        _headers['Content-Type'] = 'application/json';
      }

      dio = Dio(
        BaseOptions(
          baseUrl: baseURL ?? _baseURL,
          headers: _headers,
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
          // if (saveCredentials &&
          //     response.data?[StoredValues.token.name] != null) {
          //   StorageHandler.instance.setString(StoredValues.token.name,
          //       response.data?[StoredValues.token.name]);
          // }
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
