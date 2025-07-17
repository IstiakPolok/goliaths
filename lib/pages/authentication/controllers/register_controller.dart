import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goliaths/routes.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> registerUser() async {
    final nameParts = fullNameController.text.trim().split(' ');
    final firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    print(" Attempting to register user...");
    print(" Email: ${emailController.text.trim()}");
    print(" Password: ${passwordController.text.trim()}");
    print(" First Name: $firstName");
    print(" Last Name: $lastName");

    if (passwordController.text != confirmPasswordController.text) {
      print(" Passwords do not match");
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    isLoading.value = true;

    try {
      final url = Uri.parse('http://10.10.13.16:1000/api/auth/signup/');
      print(" Sending POST request to $url");

      final body = jsonEncode({
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "first_name": firstName,
        "last_name": lastName,
      });

      print("📦 Request body: $body");

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print(" Response status code: ${response.statusCode}");
      print(" Response body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("🎉 Registration successful");
        Get.snackbar(
          "Success",
          data["message"] ?? "User registered successfully",
        );
        Get.toNamed(
          AppRoutes.verifyOtp,
          arguments: {'email': emailController.text.trim()},
        );
      } else {
        print("⚠️ Registration failed with message: ${data["message"]}");
        Get.snackbar("Failed", data["message"] ?? "Registration failed");
      }
    } catch (e) {
      print(" Error occurred: $e");
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
      print(" Done registering user");
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
