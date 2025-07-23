part of '../_pages.dart';

class ControllerPrivacy extends GetxController {
  var isLoading = false.obs;
  var title = ''.obs;
  var content = ''.obs;

  @override
  void onInit() {
    fetchPrivacyPolicy();
    super.onInit();
  }

  Future<void> fetchPrivacyPolicy() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(Urls.privacy));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        title.value = data['title'] ?? '';
        content.value = data['content'] ?? '';
      } else {
        Get.snackbar('Error', 'Failed to load privacy policy');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
