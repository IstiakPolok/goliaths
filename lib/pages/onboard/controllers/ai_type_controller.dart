import 'dart:convert';
import 'package:get/get.dart';
import 'package:goliaths/network_caller/endpoints.dart';
import 'package:goliaths/routes.dart';
import 'package:goliaths/services_class/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;

class AiTypeController extends GetxController {
  var isLoading = false.obs;

  Future<void> selectMode(String mode) async {
    isLoading.value = true;

    final token = await SharedPreferencesHelper.getAccessToken();
    print("🔐 Retrieved Token: $token");

    final url = Uri.parse(Urls.aimodeseletion);
    print("🌐 API URL: $url");

    try {
      final bodyData = jsonEncode({'mode': mode});
      print("📦 Request Body: $bodyData");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'JWT $token',
        },
        body: bodyData,
      );

      print("📩 Status Code: ${response.statusCode}");
      print("🧾 Response Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 && data['conversation_id'] != null) {
        print("✅ Success: ${data['message']}");

        // Save selected mode to SharedPreferences
        await SharedPreferencesHelper.saveSelectedAiMode(mode);

        Get.snackbar("Success", data['message'] ?? "Mode selected");
      } else {
        print("❌ API Error: ${data['message']}");
        Get.snackbar("Error", data['message'] ?? "Failed to select mode");
      }
    } catch (e) {
      print("⚠️ Exception: $e");
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
      print("🔄 Loading Finished");
    }
  }

}
