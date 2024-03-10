import 'package:get/get_connect/connect.dart';
import 'package:icet/cache/cachemanager.dart';


class APIServiceProvider extends GetConnect with CacheManager {
  final String _baseUrl = "http://127.0.0.1:8000";
  final String _prod_baseUrl = "https://icet-django.fly.dev";

  @override
  void onInit() {
    super.onInit();
    // All request will pass to jsonEncode so CasesModel.fromJson()
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['accept'] = 'application/json';
      request.headers['Access-Control-Allow-Origin'] = '*';
      request.headers['User-Agent'] = 'web';
      return request;
    });

  }

  // Get request
  Future<Response<List<dynamic>>> getBoard() {
    var token = getToken();
    return get('$_baseUrl/api/boards/', headers: {
      'Authorization' : 'Token $token',
      'accept' : 'application/json',
      'Access-Control-Allow-Origin' : '*',
      'Content-Type' : 'application/json'
    });
  }

  Future<Response<List<dynamic>>> addBoard(Map data) => post('$_baseUrl/api/boards/', data, headers: {
    'Authorization' : 'Token $getToken',
  });

  // Post Sign up request
  Future<Response> signupUser(Map data) => post('$_baseUrl/api/users/', data);

  // Post Sign in request
  Future<Response> signinUser(Map data) => post('$_baseUrl/api/api-token-auth/', data);

  // Post request with File

  GetSocket userMessages() {
    return socket('https://yourapi/users/socket');
  }
}
