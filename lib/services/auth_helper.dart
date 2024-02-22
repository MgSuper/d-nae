import 'dart:convert';

import 'package:deenae/models/auth/login_model.dart';
import 'package:deenae/models/auth/profile_model.dart';
import 'package:deenae/models/auth/register_model.dart';
import 'package:deenae/models/auth_response/login_res_model.dart';
import 'package:deenae/services/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = http.Client();

  Future<bool> login(Login model) async {
    print('login $login');
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiUrl, Config.loginUrl);
    print('requestHeaders $requestHeaders');
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    print('response $response');

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userToken = loginResponseFromJson(response.body).token;
      String userId = loginResponseFromJson(response.body).id;
      await prefs.setString('token', userToken);
      await prefs.setString('userID', userId);
      await prefs.setBool('isLoggedIn', true);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(Register login) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiUrl, Config.registerUrl);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(login.toJson()));

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<Profile> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $userToken'
    };
    var url = Uri.http(Config.apiUrl, Config.getUserUrl);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var profile = ProfileFromJson(response.body);
      return profile;
    } else {
      throw Exception('Failed to get profile');
    }
  }
}
