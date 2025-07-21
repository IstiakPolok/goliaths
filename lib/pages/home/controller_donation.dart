part of '../_pages.dart';

class Donation {
  final int id; // 👈 add this
  final String? donorName;
  final String? donorEmail;
  final String message;
  final String amount;
  final String currency;
  final String donatedAt;
  final String status;

  Donation({
    required this.id, // 👈 mark as required
    this.donorName,
    this.donorEmail,
    required this.message,
    required this.amount,
    required this.currency,
    required this.donatedAt,
    required this.status,
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'],
      donorName: json['donor_name'] ?? 'Anonymous',
      donorEmail: json['donor_email'] ?? 'N/A',
      message: json['message'] ?? 'No message',
      amount: json['amount'] ?? '0.00',
      currency: json['currency'] ?? 'USD',
      donatedAt: json['donated_at'] ?? '',
      status: json['payment_status'] ?? 'pending',
    );
  }
}

class DonationSummary {
  final String? image;
  final String? name;
  final String? fundraisedAmount;

  DonationSummary({this.image, this.name, this.fundraisedAmount});

  factory DonationSummary.fromJson(Map<String, dynamic> json) {
    return DonationSummary(
      image: json['image'],
      name: json['name'],
      fundraisedAmount: json['fundraisedAmount'],
    );
  }
}

class DonationOrganizationSimple {
  final String image;
  final String name;
  final String fundraisedAmount;

  DonationOrganizationSimple({
    required this.image,
    required this.name,
    required this.fundraisedAmount,
  });
}

class ControllerDonation extends GetxController {
  final selectedAmount = 0.obs;

  final RxList<DonationOrganizationSimple> donationSummaries =
      [
        DonationOrganizationSimple(
          image: "https://images.unsplash.com/photo-1509099836639-18ba02f0b9b8",
          name: "Hope for Children",
          fundraisedAmount: "\$31500",
        ),
        DonationOrganizationSimple(
          image: "https://images.unsplash.com/photo-1587502537745-84b48f77c9aa",
          name: "Green Earth Foundation",
          fundraisedAmount: "\$48300",
        ),
        DonationOrganizationSimple(
          image: "https://images.unsplash.com/photo-1603393071235-118d5d6c48c4",
          name: "Water For All",
          fundraisedAmount: "\$18700",
        ),
        DonationOrganizationSimple(
          image: "https://images.unsplash.com/photo-1565372914781-2be7a040af24",
          name: "Animal Rescue Alliance",
          fundraisedAmount: "\$39200",
        ),
        DonationOrganizationSimple(
          image: "https://images.unsplash.com/photo-1580633018526-3c0f0b4b7a2b",
          name: "Global Health Initiative",
          fundraisedAmount: "\$78600",
        ),
      ].obs;

  RxString totalDonated = '0.00'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDonationsList(); // Automatically fetch on load
    fetchTotalDonated();
  }

  RxList<Donation> donations = <Donation>[].obs;

  Future<void> fetchDonationsList() async {
    try {
      final token = await SharedPreferencesHelper.getAccessToken();
      final response = await http.get(
        Uri.parse('${Urls.baseUrl}/donations/'),
        headers: {'Authorization': 'JWT $token'},
      );

      print('🔍 Donations Status: ${response.statusCode}');
      print('📦 Donations Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        donations.value = jsonList.map((e) => Donation.fromJson(e)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load donation list');
      }
    } catch (e) {
      print('❌ Error fetching donations: $e');
      Get.snackbar('Error', 'Could not fetch donations');
    }
  }

  Future<void> createCheckoutSession({
    required String amount,
    required int campaign_id,
    String donorName = "Anonymous",
    String donorEmail = "anonymous@example.com",
    String message = "Thank you!",
  }) async {
    try {
      final token = await SharedPreferencesHelper.getAccessToken();

      final body = jsonEncode({
        "amount": amount,
        "campaign_id": campaign_id,
        "donor_name": donorName,
        "donor_email": donorEmail,
        "message": message,
      });

      final response = await http.post(
        Uri.parse("${Urls.baseUrl}/donation/create-checkout-session/"),
        headers: {
          'Authorization': 'JWT $token',
          'Content-Type': 'application/json',
        },
        body: body,
      );

      print('✅ Status: ${response.statusCode}');
      print('📦 Response: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final checkoutUrl = responseData["checkout_url"];

        if (checkoutUrl != null && checkoutUrl.toString().isNotEmpty) {
          // ✅ Open the donation WebView page
          Get.to(() => ScreenWebview(url: checkoutUrl));
        } else {
          Get.snackbar('Error', 'Checkout URL not found');
        }
      } else {
        final error = jsonDecode(response.body);
        Get.snackbar('Error', error.toString());
      }
    } catch (e) {
      print('❌ Error: $e');
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  Future<void> fetchTotalDonated() async {
    try {
      final token = await SharedPreferencesHelper.getAccessToken();
      final response = await http.get(
        Uri.parse(Urls.donationSummary),
        headers: {'Authorization': 'JWT $token'},
      );

      print('🔍 Status Code: ${response.statusCode}');
      print('📦 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        totalDonated.value = data['total_donated'] ?? '0.00';
      } else {
        Get.snackbar('Error', 'Failed to fetch donation data');
      }
    } catch (e) {
      print('❌ Error fetching total donated: $e');
      Get.snackbar('Error', 'An error occurred');
    }
  }
}
