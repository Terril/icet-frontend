import 'package:get/get_connect/connect.dart';

import '../datamodel/boards.dart';

class OverviewboardProvider extends GetConnect {
  final String _baseUrl = "http://127.0.0.1:8000";

  @override
  void onInit() {
    // All request will pass to jsonEncode so CasesModel.fromJson()
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['accept'] = 'application/json';
      request.headers['Access-Control-Allow-Origin'] = '*';
      request.headers['User-Agent'] = 'web';
      return request;
    });

    //Todo : Need to implement this in future
    httpClient.addAuthenticator<dynamic>((request) async {
      Map data = <String, String>{};
      data = {
        "username" : "BB",
        "password" : "aaa"
      };
      final response = await post(_baseUrl, data);
      final token = response.body['token'];
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
  Future<Response> postBoard(Map data) => post(_baseUrl, data);

  // Post request with File

  GetSocket userMessages() {
    return socket('https://yourapi/users/socket');
  }
}
