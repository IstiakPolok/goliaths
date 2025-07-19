import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../network_caller/endpoints.dart';
import '../../../routes.dart';
import '../../../services_class/shared_preferences_helper.dart';


class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please enter both email and password");
      return;
    }

    isLoading.value = true;

    try {
      final loginUrl = Uri.parse(Urls.login); // Update with your actual login URL
      final body = jsonEncode({"email": email, "password": password});

      final response = await http.post(
        loginUrl,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = data["access"];
        final userId = data["user"]["id"].toString();

        await SharedPreferencesHelper.saveToken(token);
        await SharedPreferencesHelper.saveUserId(userId);

        Get.snackbar("Success", data["message"] ?? "Login successful");
        Get.offAllNamed(AppRoutes.onboard); // ✅ Navigate to onboard screen
      } else {
        Get.snackbar("Login Failed", data["message"] ?? "Invalid credentials");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
