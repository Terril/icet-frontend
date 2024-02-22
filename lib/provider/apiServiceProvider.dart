import 'package:get/get_connect/connect.dart';

import '../datamodel/token.dart';

class APIServiceProvider extends GetConnect {
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

    //Todo : Need to implement this in future
    httpClient.addAuthenticator<dynamic>((request) async {
      print(httpClient.baseUrl);
      Map data = <String, String>{};
      data = {
        "username" : "BB",
        "password" : "aaa"
      };
      final response = await post('$_baseUrl/api/api-token-auth/', data);
      final token = Token.fromJson(response.body);
      print(token);
      // Set the header
      request.headers['Authorization'] = "Token $token";
      return request;
    });

  }

  // Get request
  Future<Response<List<dynamic>>> getBoard() => get('$_baseUrl/api/boards/', headers: {
    'Authorization' : 'Token 3372bd9880a5644b51b5f008b39adef82b524973'
  });

  // Post request
  Future<Response> signupUser(Map data) => post('$_baseUrl/api/users/', data);

  // Post request with File

  GetSocket userMessages() {
    return socket('https://yourapi/users/socket');
  }
}
