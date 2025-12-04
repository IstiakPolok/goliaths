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
    super.onInit();
    print('🟢 ControllerHistory initialized');
    fetchHistory();
  }

  @override
  void onReady() {
    super.onReady();
    print('🟢 ControllerHistory ready - fetching latest history');
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    print('🔄 Fetching chat history...');
    isLoading.value = true;

    final token = await SharedPreferencesHelper.getAccessToken();
    print('🔑 Token: $token');

    final url = Uri.parse(Urls.chatList);
    print('🌐 API URL: $url');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'JWT $token',
          'Content-Type': 'application/json',
        },
      );

      print('📡 Response Status: ${response.statusCode}');
      print('📦 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('✅ Parsed ${data.length} conversations');

        historyList.value =
            data
                .map((item) => ConversationModel.fromJson(item))
                .toList()
                .reversed
                .toList();

        print('📋 Updated historyList (length: ${historyList.length})');
      } else {
        print('❌ Failed to load history: ${response.statusCode}');
        Get.snackbar("Error", "Failed to load history");
      }
    } catch (e) {
      print('🚨 Exception while fetching history: $e');
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
      print('✅ Fetch completed. isLoading = ${isLoading.value}');
    }
  }
}
