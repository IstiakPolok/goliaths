part of '../_pages.dart';

class ControllerTerms extends GetxController {
  var isLoading = false.obs;
  var title = ''.obs;
  var terms = ''.obs;

  @override
  void onInit() {
    fetchTerms();
    super.onInit();
  }

  Future<void> fetchTerms() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(Urls.terms));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        title.value = data['title'] ?? 'Terms & Conditions';
        terms.value = data['content'] ?? '';
      } else {
        Get.snackbar('Error', 'Failed to load Terms & Conditions');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
