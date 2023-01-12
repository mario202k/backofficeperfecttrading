import 'dart:io';

import 'package:backoffice/src/exceptions/app_exception.dart';
import 'package:dio/dio.dart';

import '../constants/k_preferences.dart';

class HttpService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://api-fxpractice.oanda.com/v3/instruments/",
    connectTimeout: 20000,
    receiveTimeout: 20000,
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
  ));

  HttpService._() {
    setAccessToken(kAccessToken);
  }

  static final instance = HttpService._();

  void setAccessToken(String accessToken) {
    _dio.options.headers.addAll({'Authorization': ('Bearer $accessToken')});
  }

  Future<T> get<T>(
      {required String path,
      Map<String, dynamic>? body,
      Function(int count, int total)? onReceiveProgress,
      required T Function(dynamic data) builder,
      Options? options,
      Map<String, dynamic>? queryParameters}) async {
    Response response;

    try {
      response = await _dio.get(path,
          onReceiveProgress: onReceiveProgress,
          options: options,
          queryParameters: queryParameters);
    } on DioError catch (dioError) {
      throw AppException.unknown(switchErrorMessage(dioError));
    }

    return builder(response.data);
  }

  String switchErrorMessage(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectTimeout:
        return "Time out";
      case DioErrorType.sendTimeout:
        return "sendTimeout";
      case DioErrorType.receiveTimeout:
        return "Time out";
      case DioErrorType.response:
        final errCode = dioError.response?.statusCode;
        final data = (dioError.response?.data);
        String message = "";
        if (data is String) {
          message = data;
        } else if (data is Map) {
          message = data["detail"].toString();
        } else if (data is List) {
          message = data.elementAt(0)["detail"]["msg"];
        }
        return message;

      case DioErrorType.cancel:
        return "cancel";
      case DioErrorType.other:
        if (dioError.error is SocketException) {
          return "No internet connection";
        }
        return "Undefined error";
      default:
        return "Undefined error";
    }
  }
}
