import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:goliaths/services_class/shared_preferences_helper.dart';
import 'package:goliaths/network_caller/endpoints.dart';

class ProfileModel {
  final int id;
  final String email;
  final String full_name;
  final String phoneNumber;
  final bool isVerified;
  final String? profilePicture;
  final String dateOfBirth;
  final int age;

  ProfileModel({
    required this.id,
    required this.email,
    required this.full_name,
    required this.phoneNumber,
    required this.isVerified,
    required this.profilePicture,
    required this.dateOfBirth,
    required this.age,
  });

  String get name => full_name;

  String get avatarUrl => profilePicture ?? '';

  String get formattedDateOfBirth {
    try {
      final date = DateTime.parse(dateOfBirth);
      final month = date.month.toString().padLeft(2, '0');
      final day = date.day.toString().padLeft(2, '0');
      final year = date.year.toString(); // ← full YYYY
      return "$month-$day-$year";
    } catch (e) {
      return dateOfBirth;
    }
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      full_name: json['full_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      isVerified: json['is_verified'] ?? false,
      profilePicture: json['profile_picture'], // nullable, okay
      dateOfBirth: json['date_of_birth'] ?? '',
      age: json['age'] ?? 0,
    );
  }
}

class ProfileController extends GetxController {
  Rx<ProfileModel?> profile = Rx<ProfileModel?>(null);
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    fetchProfile();
    super.onInit();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;

      final token = await SharedPreferencesHelper.getAccessToken();
      print("Access Token: $token");

      final response = await http.get(
        Uri.parse(Urls.profileupdate),
        headers: {"Authorization": "JWT $token"},
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Decoded JSON: $data");

        profile.value = ProfileModel.fromJson(data);
        print("Parsed Profile: ${profile.value}");
        print("Name: ${profile.value?.name}");
        print("Email: ${profile.value?.email}");
        final subscriptions = data['subscriptions'];
        if (subscriptions != null &&
            subscriptions is List &&
            subscriptions.isNotEmpty &&
            subscriptions[0]['plan'] != null &&
            subscriptions[0]['plan']['id'] != null) {
          final int planId = subscriptions[0]['plan']['id'];
          await SharedPreferencesHelper.saveSubscriptionId(planId);
          print("✅ Plan ID saved: $planId");
        } else {
          print("⚠️ No valid plan ID found.");
        }
      } else {
        print("Failed to fetch profile: ${response.statusCode}");
        profile.value = null;
      }
    } catch (e) {
      profile.value = null;
      print("Profile fetch error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

Future<void> uploadProfilePicture(File imageFile) async {
  const String url = Urls.profileupdate;

  try {
    final token = await SharedPreferencesHelper.getAccessToken();
    final request =
        http.MultipartRequest('PATCH', Uri.parse(url))
          ..headers['Authorization'] = 'JWT $token'
          ..headers['Content-Type'] = 'multipart/form-data'
          ..files.add(
            await http.MultipartFile.fromPath(
              'profile_picture',
              imageFile.path,
            ),
          );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print("✅ Status: ${response.statusCode}");
    print("✅ Response body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 202) {
      print("✅ Upload successful!");
    } else {
      print("❌ Upload failed: ${response.statusCode}");
    }
  } catch (e) {
    print("❌ Exception occurred: $e");
  }
}
