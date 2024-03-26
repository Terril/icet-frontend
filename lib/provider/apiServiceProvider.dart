import 'dart:collection';

import 'package:get/get_connect/connect.dart';
import 'package:icet/cache/cachemanager.dart';

import '../logs.dart';


class APIServiceProvider extends GetConnect with CacheManager {
  final String _baseUrl = "http://127.0.0.1:8000";
  final String _prod_baseUrl = "https://icet-django.fly.dev";

  String _getUrl() => _baseUrl;

  // Get request
  Future<Response<List<dynamic>>> getBoard() {
    var token = getToken();
    Logger.printLog(message: "$token");
    return get('$_baseUrl/api/boards/', headers: {
      'Authorization' : 'Token $token',
      'accept' : 'application/json',
      'Access-Control-Allow-Origin' : '*',
      'Content-Type' : 'application/json'
    });
  }

  Future<Response<List<dynamic>>> addBoard(Map data) {
    var token = getToken();
    return post('$_baseUrl/api/boards/', data, headers: {
    'Authorization' : 'Token $token',
    });
  }

  // Post Custom board request
  Future<Response> getApiBoardsCustom() {
    Map<String, dynamic> map = HashMap();
    map["board_name"] = "Custom";
    map["column_names"] = ["Interest level", "Checklist 1", "Checklist 2", "Checklist 3"];
    map["row_names"] = ["Asset 1", "Asset 2", "Asset 3"];

    var token = getToken();
    Logger.printLog(message: "$token");
    return post('$_baseUrl/api/boards/custom/', map, headers: {
      'Authorization' : 'Token $token',
    });
  }

  Future<Response> getColumnsByBoardId(String? boardId) {
    var token = getToken();
    Logger.printLog(message: "$token");
    return get('$_baseUrl/api/boards/$boardId/columns', headers: {
      'Authorization' : 'Token $token',
    });
  }

  // Column is nothing but the checklist
  Future<Response<List<dynamic>>> addColumn(Map data) {
    var token = getToken();
    return post('$_baseUrl/api/columns/', data, headers: {
      'Authorization' : 'Token $token',
    });
  }


  // Post Sign up request
  Future<Response> signupUser(Map data) => post('$_baseUrl/api/users/', data);

  // Post Sign in request
  Future<Response> signinUser(Map data) => post('$_baseUrl/api/api-token-auth/', data);

  // Post request with File

  GetSocket userMessages() {
    return socket('https://yourapi/users/socket');
  }
}
