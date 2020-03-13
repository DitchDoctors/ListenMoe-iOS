

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:listenmoe/main.dart';

import '../constants.dart';

class ListenMoeRequests {
static const Map<String, String> headers = {
  'Accept': 'application/vnd.listen.v4+json',
  'Content-Type' : 'application/json',
};

  Dio get _moeRequests {
    final BaseOptions _baseOptions = BaseOptions(
      headers: Map<String, String>.from(headers),
      baseUrl: 'https://listen.moe/api',
    );
    Dio _dio = Dio(_baseOptions);
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions request) {
        if (request.method == 'POST') request.contentType = Headers.formUrlEncodedContentType; 
        
        return request;
      }
    ));
    return _dio;
  }

  //Email is also acceptable
  Future<int> authenticateUser({@required String username, @required String password}) async {
    final _userCredentials = {'username': username, 'password': password};
    
    try {

    final Response _response = await _moeRequests.post('/login', data: _userCredentials,);
    final data = _AuthForm.fromJson(_response.data);

    if (data.token != null) {
      print('passed!');
      pref.setString(userToken, data.token);
      return 200;
    } 
    } on DioError catch (e) {
       return e.response.statusCode;
    }
  return null;
  }

}

class _AuthForm {
  final String token;
  final String apiKey;
  _AuthForm({this.token, this.apiKey});
  factory _AuthForm.fromJson(Map<String, dynamic> json) => 
  _AuthForm(
    token: json['token'],
    apiKey: json['apiKey'],
  );
}

