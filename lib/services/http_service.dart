import 'package:dio/dio.dart';

import '../app/app.logger.dart';
import '../enums/request_type.dart';

class HttpService {
  final _log = getLogger('HttpService');
  final dio = Dio();

  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _makeRequest<T>(
      url,
      requestType: RequestType.get,
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  Future<Response<T>> post<T>(
    String url, {
    Map<String, dynamic>? payload,
    Map<String, dynamic>? headers,
  }) async {
    return _makeRequest<T>(
      url,
      requestType: RequestType.post,
      payload: payload,
      headers: headers,
    );
  }

  Future<Response<T>> put<T>(
    String url, {
    Map<String, dynamic>? payload,
    Map<String, dynamic>? headers,
  }) async {
    return _makeRequest<T>(
      url,
      requestType: RequestType.put,
      payload: payload,
      headers: headers,
    );
  }

  Future<Response<T>> patch<T>(
    String url, {
    Map<String, dynamic>? payload,
    Map<String, dynamic>? headers,
  }) async {
    return _makeRequest<T>(
      url,
      requestType: RequestType.patch,
      payload: payload,
      headers: headers,
    );
  }

  Future<Response<T>> delete<T>(
    String url, {
    Map<String, dynamic>? payload,
    Map<String, dynamic>? headers,
  }) async {
    return _makeRequest<T>(
      url,
      requestType: RequestType.delete,
      payload: payload,
      headers: headers,
    );
  }

  Future<Response<T>> _makeRequest<T>(
    String url, {
    required RequestType requestType,
    Map<String, dynamic>? payload,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      _log.d(
        'url "$url"\nrequestType"$requestType"\npayload "$payload"\nrequestHeaders: "$headers"',
      );

      final Options options = Options(
        headers: headers,
      );

      switch (requestType) {
        case RequestType.get:
          return dio.get<T>(
            url,
            queryParameters: queryParameters,
            options: options,
          );

        case RequestType.post:
          return dio.post<T>(
            url,
            data: payload,
            options: options,
          );

        case RequestType.put:
          return dio.put<T>(
            url,
            data: payload,
            options: options,
          );

        case RequestType.patch:
          return dio.patch<T>(
            url,
            data: payload,
            options: options,
          );

        case RequestType.delete:
          return dio.delete<T>(
            url,
            data: payload,
            options: options,
          );

        default:
          return dio.get<T>(
            url,
            options: options,
          );
      }
    } on DioError catch (error) {
      _log.e(error);
      rethrow;
    } catch (error) {
      _log.e(error);
      rethrow;
    }
  }
}
