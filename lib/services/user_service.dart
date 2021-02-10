import 'dart:async';
import 'dart:convert';

import 'package:login_test/model/login_request.dart';
import 'package:login_test/model/login_response.dart';
import 'package:http/http.dart' as http;

class UserService {
  static UserService _instance = new UserService.internal();
  UserService.internal();
  factory UserService() => _instance;

  static final BASE_URL = "https://vouchernet.com.ng/vadmin/api2/apiLine.php";
  static final LOGIN_URL = BASE_URL + "/login.php";

  Future<Map<String, dynamic>> login(LoginRequest request) async {
    final http.Response response = await http.post(
      BASE_URL,
      headers: <String, String>{
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: request.toJson(),
    );
    if (response.statusCode == 200) {
       return jsonDecode(response.body);
    } else {
      throw Exception("An error really occured");
    }
  }
}
