part of '../_pages.dart';

class ControllerSubscription extends GetxController {
  /// Indicates if the subscription is active
  final RxBool isActive = false.obs;

  /// Holds the list of available subscription plans
  final RxList<Map<String, dynamic>> plans = <Map<String, dynamic>>[].obs;

  /// Loading state for fetching plans
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    print('DEBUG: ControllerSubscription onInit called.');
    fetchPlans();
  }

  /// Fetches subscription plans from API and updates the `plans` list
  Future<void> fetchPlans() async {
    isLoading.value = true;
    print('DEBUG: fetchPlans started. isLoading set to true.');

    try {
      final token = await SharedPreferencesHelper.getAccessToken();
      print(
        'DEBUG: Retrieved access token: ${token != null && token.isNotEmpty ? "Token found" : "Token not found/empty"}',
      );

      if (token == null || token.isEmpty) {
        Get.snackbar("Error", "Access token not found. Please log in again.");
        print('DEBUG: Access token is null or empty. Aborting fetchPlans.');
        return;
      }

      final uri = Uri.parse(Urls.planlist);
      print('DEBUG: API URL for plan list: $uri');

      final response = await http.get(
        uri,
        headers: {
          'Authorization': "JWT $token",
          'Content-Type': 'application/json',
        },
      );

      print('DEBUG: API Response Status Code: ${response.statusCode}');
      print('DEBUG: API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        plans.value = data.cast<Map<String, dynamic>>();
        print('DEBUG: Successfully loaded ${plans.length} subscription plans.');
      } else {
        Get.snackbar(
          "Error",
          "Failed to load subscription plans. Status: ${response.statusCode}",
        );
        print(
          "ERROR: Failed to load subscription plans. Response body: ${response.body}",
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong: Check your internet connection or try again later.",
      );
      print("EXCEPTION: An error occurred during fetchPlans: $e");
    } finally {
      isLoading.value = false;
      print('DEBUG: fetchPlans finished. isLoading set to false.');
    }
  }

  /// Creates a checkout session for a selected plan
  Future<void> createCheckoutSession(Map<String, dynamic> plan) async {
    print("DEBUG: createCheckoutSession called for plan: ${plan["name"]}");

    try {
      final token = await SharedPreferencesHelper.getAccessToken();
      print("DEBUG: Access token: ${token != null ? "Available" : "NULL"}");

      if (token == null) {
        Get.snackbar("Error", "You must be logged in to subscribe.");
        print("ERROR: Cannot proceed without token.");
        return;
      }

      final planId = plan["id"];
      if (planId == null) {
        print("❌ ERROR: Plan ID not found in plan object.");
        Get.snackbar("Error", "Plan ID is missing.");
        return;
      }

      final bodyData = {
        "name": plan["name"],
        "description": plan["description"],
        "price": plan["price"],
        "duration_days": plan["duration_days"],
        "features":
            (plan["features"] as List).map((f) => f["description"]).toList(),
      };

      print("DEBUG: Checkout request body => ${jsonEncode(bodyData)}");

      final url =
          'http://10.10.13.16:9100/api/plans/$planId/create_checkout_session/';
      print("DEBUG: Full checkout URL => $url");

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'JWT $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(bodyData),
      );

      print("DEBUG: Checkout API Status Code: ${response.statusCode}");
      print("DEBUG: Checkout API Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final checkoutUrl = data['checkout_url'];

        if (checkoutUrl != null && checkoutUrl.isNotEmpty) {
          print("✅ CHECKOUT URL: $checkoutUrl");

          /// ✅ Open WebView with the checkout URL
          Get.to(() => ScreenWebview(url: checkoutUrl));
        } else {
          print("❌ ERROR: Checkout URL not found in response.");
          Get.snackbar("Error", "Checkout URL not found.");
        }
      } else {
        Get.snackbar("Error", "Failed to initiate checkout.");
        print("❌ Checkout failed: ${response.body}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
      print("❌ EXCEPTION during checkout: $e");
    }
  }
}
