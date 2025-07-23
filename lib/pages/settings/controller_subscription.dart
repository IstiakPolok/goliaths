part of '../_pages.dart';

class ControllerSubscription extends GetxController {
  /// Indicates if the subscription is currently active
  final RxBool isActive = false.obs;

  /// List of all available subscription plans
  final RxList<Map<String, dynamic>> plans = <Map<String, dynamic>>[].obs;

  /// Loading state while fetching plans
  final RxBool isLoading = false.obs;

  /// Holds the currently subscribed plan ID
  final RxInt currentSubscribedPlanId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    print('DEBUG: ControllerSubscription onInit called.');
    _loadCurrentSubscribedPlanId();
    fetchPlans();
  }

  /// Load the current subscription ID from local storage
  Future<void> _loadCurrentSubscribedPlanId() async {
    final savedSubId = await SharedPreferencesHelper.getSubscriptionId();
    if (savedSubId != null) {
      currentSubscribedPlanId.value = savedSubId;
      print("DEBUG: Loaded current subscribed plan ID: $savedSubId");
    }
  }

  /// Fetch available subscription plans from the backend
  Future<void> fetchPlans() async {
    isLoading.value = true;
    print('DEBUG: fetchPlans started. isLoading set to true.');

    try {
      final token = await SharedPreferencesHelper.getAccessToken();
      print('DEBUG: Access token: ${token?.isNotEmpty == true ? "✔ Available" : "❌ Missing"}');

      if (token == null || token.isEmpty) {
        Get.snackbar("Error", "Access token not found. Please log in again.");
        return;
      }

      final uri = Uri.parse(Urls.planlist);
      print('DEBUG: API URL: $uri');

      final response = await http.get(
        uri,
        headers: {
          'Authorization': "JWT $token",
          'Content-Type': 'application/json',
        },
      );

      print('DEBUG: API Status Code: ${response.statusCode}');
      print('DEBUG: API Response: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        plans.value = data.cast<Map<String, dynamic>>();
        print('✅ Loaded ${plans.length} subscription plans.');

        for (var plan in plans) {
          if (plan['id'] == currentSubscribedPlanId.value) {
            print("🎯 MATCH FOUND: '${plan['name']}' (ID: ${plan['id']}) is the current subscription.");
          }
        }
      } else {
        Get.snackbar("Error", "Failed to load plans. (${response.statusCode})");
      }
    } catch (e) {
      print("❌ EXCEPTION in fetchPlans: $e");
      Get.snackbar("Error", "Something went wrong. Try again later.");
    } finally {
      isLoading.value = false;
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
