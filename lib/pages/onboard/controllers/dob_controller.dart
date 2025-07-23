import 'dart:convert';
import 'package:get/get.dart';
import 'package:goliaths/routes.dart';
import 'package:http/http.dart' as http;
import 'package:goliaths/services_class/shared_preferences_helper.dart';
import 'package:goliaths/network_caller/endpoints.dart';

class DobController extends GetxController {
  var isLoading = false.obs;

  Future<void> updateDateOfBirth(String dob) async {
    isLoading.value = true;

    final token = await SharedPreferencesHelper.getAccessToken();
    final url = Uri.parse(Urls.profileupdate);

    print("🚀 Starting DOB update...");
    print("🔑 JWT Token: $token");
    print("📡 PATCH URL: $url");
    print("📦 Request Body: ${jsonEncode({'date_of_birth': dob})}");

    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'JWT $token',
        },
        body: jsonEncode({'date_of_birth': dob}),
      );

      print("📥 Response Status Code: ${response.statusCode}");
      print("📥 Response Body: ${response.body}");

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 202) {
        Get.snackbar("✅ Success", "Date of Birth updated successfully");
        Get.toNamed(AppRoutes.home);
      } else {
        Get.snackbar("❌ Error", data['message'] ?? "Update failed");
      }
    } catch (e) {
      print("❌ Exception: $e");
      Get.snackbar("❌ Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
      print("🛑 Loading Stopped");
    }
  }
}
