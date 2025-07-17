part of '../_pages.dart';

class ControllerOnboard extends GetxController {
  final selectedAssistantIndex = RxInt(-1);

  final currentPage = RxInt(0);
  final totalPages = 4;

  final pageViewController = PageController();

  // Assistant data
  final List<Map<String, dynamic>> assistants = [
    {'name': 'JANE', 'age': 25, 'image': 'assets/images/avatar_1.png'},
    {'name': 'ALEX', 'age': 28, 'image': 'assets/images/avatar_2.png'},
    {'name': 'MICHAEL', 'age': 30, 'image': 'assets/images/avatar_3.png'},
    {'name': 'SARAH', 'age': 26, 'image': 'assets/images/avatar_4.png'},
  ];

  @override
  void onInit() {
    super.onInit();
    ever(currentPage, (value) {
      if (value == pageViewController.page?.toInt()) return;
      pageViewController.animateToPage(
        currentPage.value,
        duration: Duration(milliseconds: 300), // Medium duration for smooth transition
        curve: Curves.easeInOut, // Smooth curve for better feel
      );
    });
  }

  void nextPage() {
    if (currentPage.value < totalPages - 1) {
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }

  void selectAssistant(int? index) {
    // Save selected assistant and navigate
    final selectedAssistant = assistants[index ?? currentPage.value];
    // You can store this in shared preferences or another persistent storage
  }
}
