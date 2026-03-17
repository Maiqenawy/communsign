import 'dart:convert';
import 'dart:io';
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
      headers: {"Content-Type": "application/json"},
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
      headers: {"Content-Type": "application/json"},
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
      body: jsonEncode({"email": email}),
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

  // ================= TEXT TO SIGNS =================
  static Future<List<String>> textToSigns(String text) async {

    final response = await http.post(
      Uri.parse("$baseUrl/ai/text-to-signs"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"text": text}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(data["Signs"]);
    } else {
      throw Exception("Translation failed");
    }
  }

  // ================= SIGN FRAME TO TEXT =================
  static Future<String> signToText(File image) async {

    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/ai/sign-to-text"),
    );

    request.files.add(
      await http.MultipartFile.fromPath("Frame", image.path),
    );

    var response = await request.send();
    var res = await http.Response.fromStream(response);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data["text"];
    } else {
      throw Exception("AI prediction failed");
    }
  }
}
