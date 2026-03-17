import 'dart:convert';
import 'package:http/http.dart' as http;

class Service {

  static const String baseUrl = "http://cominisign.runasp.net/api";

  // ================= REGISTER =================
  static Future register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String address,
  }) async {

    var url = Uri.parse("$baseUrl/account/register");

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "address": address
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Register failed");
    }
  }

  // ================= LOGIN =================
  static Future login({
    required String email,
    required String password,
  }) async {

    var url = Uri.parse("$baseUrl/account/login");

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "email": email,
        "password": password
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Login failed");
    }
  }

  // ================= FORGOT PASSWORD =================
  static Future forgotPassword(String email) async {

    var url = Uri.parse("$baseUrl/account/forgot-password");

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to send email");
    }
  }

  // ================= RESET PASSWORD =================
  static Future resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {

    var url = Uri.parse("$baseUrl/account/reset-password");

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "token": token,
        "newPassword": newPassword
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Reset failed");
    }
  }
}