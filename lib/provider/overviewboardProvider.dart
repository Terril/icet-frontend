
import 'package:get/get_connect/connect.dart';

class OverviewboardProvider extends GetConnect {

   final String _baseUrl = "http://127.0.0.1:55852/";

  // Get request
  Future<Response> getBoard() => get('$_baseUrl/api/v2/boards', headers:
  {'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDk3NTEzNTUsImlhdCI6MTcwNjE1MTM1NSwic3ViIjoiNjViMWM0MmVhNTkwZjM5OGUzMmJkNjNjIn0.2yxQxxwUg495-y_mcBhZyYTtqrzbEn4_vRc5UuI5A6c',
    'content-type': 'application/json',
    'Accept': 'application/json'
  }
  );
  // Post request
  Future<Response> postBoard(Map data) => post(_baseUrl,  data);
  // Post request with File

  GetSocket userMessages() {
    return socket('https://yourapi/users/socket');
  }
}