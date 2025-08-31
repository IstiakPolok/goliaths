import 'dart:convert';
import 'package:get/get.dart';
import 'package:goliaths/network_caller/endpoints.dart';
import 'package:goliaths/services_class/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;

class BirthdateController extends GetxController {
  var isLoading = false.obs;
  var full_name = ''.obs;
  var dateOfBirth = ''.obs;
  var remainingDays = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    try {
      final token = await SharedPreferencesHelper.getAccessToken();
      print('🔑 Token: $token');

      final url = Uri.parse(Urls.profileupdate);
      print('🌐 API URL: $url');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'JWT $token',
        },
      );

      print('📦 Response Status Code: ${response.statusCode}');
      print('📨 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        full_name.value = data['full_name'] ?? '';
        dateOfBirth.value = data['date_of_birth'] ?? '';
        print('👤 Name: $full_name, 🎂 DOB: $dateOfBirth');

        remainingDays.value = _calculateRemainingDays(dateOfBirth.value);
        print('📆 Days left until birthday: ${remainingDays.value}');
      } else {
        Get.snackbar("Error", "Failed to fetch profile data");
      }
    } catch (e) {
      print('❌ Exception: $e');
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  int _calculateRemainingDays(String dob) {
    if (dob.isEmpty) return 0;

    try {
      final dobDate = DateTime.parse(dob);
      final now = DateTime.now();

      // Birthday this year
      var nextBirthday = DateTime(now.year, dobDate.month, dobDate.day);

      // If birthday already passed this year, use next year
      if (nextBirthday.isBefore(now) || nextBirthday.isAtSameMomentAs(now)) {
        nextBirthday = DateTime(now.year + 1, dobDate.month, dobDate.day);
      }

      final difference = nextBirthday.difference(now).inDays;
      return difference;
    } catch (e) {
      return 0;
    }
  }
}
