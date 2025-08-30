part of '../_pages.dart';

class BirthdayItem {
  final int id; // ← Add this
  final String name;
  final String birthday;
  final String image;

  const BirthdayItem({
    required this.id, // ← Add this
    required this.name,
    required this.birthday,
    required this.image,
  });

  DateTime get parsedDate => DateTime.tryParse(birthday) ?? DateTime(1900);

  String get formattedDate {
    final date = parsedDate;
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return "$month-$day-$year";
  }
}


class ControllerBirthDay extends GetxController {
  final todays = RxList<BirthdayItem>([]);
  final upcomings = RxList<BirthdayItem>([]);
  final allFriends = RxList<BirthdayItem>([]);
  final filteredFriends = RxList<BirthdayItem>([]);
  final searchController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_onSearchChanged);
    fetchFriendsBirthdays();
  }

  @override
  void onClose() {
    // searchController.removeListener(_onSearchChanged);
    // searchController.dispose();
    super.onClose();
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredFriends.assignAll(allFriends);
    } else {
      filteredFriends.assignAll(
        allFriends.where((item) => item.name.toLowerCase().contains(query)),
      );
    }
  }

  Future<void> fetchFriendsBirthdays() async {
    try {
      final token = await SharedPreferencesHelper.getAccessToken();
      print("🔐 Access Token: $token");

      final response = await http.get(
        Uri.parse("${Urls.baseUrl}/friends/"),
        headers: {
          "Authorization": "JWT $token",
          "Content-Type": "application/json",
        },
      );

      print("🌐 API Status: ${response.statusCode}");
      print("📦 Raw Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print("✅ Parsed Data Count: ${data.length}");

        final List<BirthdayItem> friends = data.map((item) {
          final id = item['id']; // ← Get ID
          final name = item['name'] ?? '';
          final birthday = item['birthday'] ?? '';
          final image = 'https://avatar.iran.liara.run/public';

          return BirthdayItem(id: id, name: name, birthday: birthday, image: image);
        }).toList();


        groupBirthDayList(friends);
      } else {
        Get.snackbar("Error", "Failed to fetch friends");
        print("❌ Error: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong.");
      print("🔥 Exception: $e");
    }
  }

  Future<void> deleteFriendBirthday(int id) async {
    try {
      final token = await SharedPreferencesHelper.getAccessToken();
      final response = await http.delete(
        Uri.parse("${Urls.baseUrl}/friends/$id/"),
        headers: {
          "Authorization": "JWT $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 204) {
        allFriends.removeWhere((item) => item.id == id);
        filteredFriends.removeWhere((item) => item.id == id);
        todays.removeWhere((item) => item.id == id);
        upcomings.removeWhere((item) => item.id == id);

        Get.snackbar("Deleted", "Birthday entry removed successfully.");
      } else {
        Get.snackbar("Error", "Failed to delete entry.");
        print("❌ Failed: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong.");
      print("🔥 Exception: $e");
    }
  }


  void groupBirthDayList(List<BirthdayItem> allBirthdays) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    List<BirthdayItem> birthdaysToday = [];
    List<BirthdayItem> upcomingBirthdays = [];

    for (var item in allBirthdays) {
      final date = item.parsedDate;
      final birthdayThisYear = DateTime(date.day, date.month, today.year);

      if (birthdayThisYear.month == today.month &&
          birthdayThisYear.day == today.day) {
        birthdaysToday.add(item);
      } else {
        final difference = birthdayThisYear.difference(today).inDays;
        if (difference >= 0 && difference <= 365) {
          upcomingBirthdays.add(item);
        }
      }
    }

    todays.assignAll(birthdaysToday);
    upcomings.assignAll(upcomingBirthdays);
    allFriends.assignAll(allBirthdays);
    filteredFriends.assignAll(allBirthdays); // for search
  }
}
