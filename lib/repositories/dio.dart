import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../index.dart';

class ApiConfig {
  static const apiEndPoint = "https://xaasvik-server.onrender.com/api";
  static const TOKEN = "LAQaifUvHUWMCln8ve0VmnVaMCQrKIZS";
}

class DioProvider {
  static String baseUrl = ApiConfig.apiEndPoint;
  static Dio? _instance;
  static const int _maxLineWidth = 90;
  static final _prettyDioLogger = PrettyDioLogger(
    requestHeader: false,
    requestBody: false,
    responseBody: false,
    responseHeader: false,
    error: false,
    compact: false,
    maxWidth: _maxLineWidth,
  );

  static final BaseOptions _options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 60 * 1000,
    receiveTimeout: 60 * 1000,
  );

  static Dio get httpDio {
    if (_instance == null) {
      _instance = Dio(_options);

      _instance!.interceptors.add(_prettyDioLogger);

      return _instance!;
    } else {
      _instance!.interceptors.clear();
      _instance!.interceptors.add(_prettyDioLogger);

      return _instance!;
    }
  }

  ///returns a Dio client with Access token in header
  static Dio get tokenClient {
    _addInterceptors();

    return _instance!;
  }

  ///returns a Dio client with Access token in header
  ///Also adds a token refresh interceptor which retry the request when it's unauthorized
  static Dio get dioWithHeaderToken {
    _addInterceptors();

    return _instance!;
  }

  static _addInterceptors() {
    _instance ??= httpDio;
    _instance!.interceptors.clear();
    // _instance!.interceptors.add(RequestHeaderInterceptor());
    _instance!.interceptors.add(_prettyDioLogger);
  }

  static String _buildContentType(String version) {
    return "user_defined_content_type+$version";
  }

  DioProvider.setContentType(String version) {
    _instance?.options.contentType = _buildContentType(version);
  }

  DioProvider.setContentTypeApplicationJson() {
    _instance?.options.contentType = "application/json";
  }
}

class ApiResult {
  final int statusCode;
  final String msg;
  final Map<String, dynamic> data;
  ApiResult({
    required this.statusCode,
    required this.msg,
    required this.data,
  }) : super();
}
