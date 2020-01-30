

import 'package:dio/dio.dart';

import '../Models/enums.dart';
import '../Extensions/Strings.dart';

abstract class ListenMoeRequests {
static Map<String, String> headers = {
  'Accept': 'application/vnd.listen.v4+json',
  'Content-Type' : 'application/json',
};

  Dio moeRequests({HTTPMethod method = HTTPMethod.get}) {
    final BaseOptions _baseOptions = BaseOptions(
      headers: headers,
      baseUrl: 'https://listen.moe/api',
      method: method.convertToString,
      
      
    );
    Dio _dio = Dio(_baseOptions);
    return _dio;
  }




}

