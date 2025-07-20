part of '../_pages.dart';

class ConversationModel {
  final int id;
  final String? title;
  final String? mode;
  final DateTime createdAt;

  ConversationModel({
    required this.id,
    this.title,
    this.mode,
    required this.createdAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'],
      title: json['title'],
      mode: json['mode'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class ControllerHistory extends GetxController {
  RxList<ConversationModel> historyList = <ConversationModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchHistory();
    super.onInit();
  }

  Future<void> fetchHistory() async {
    isLoading.value = true;
    final token = await SharedPreferencesHelper.getAccessToken();

    final url = Uri.parse(Urls.chatList);

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'JWT $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        historyList.value =
            data
                .map((item) => ConversationModel.fromJson(item))
                .toList()
                .reversed
                .toList();
      } else {
        Get.snackbar("Error", "Failed to load history");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
