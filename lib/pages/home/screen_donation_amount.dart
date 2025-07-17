part of '../_pages.dart';

/// ****************************************************************************
/// Donation and organization amount entry
/// ****************************************************************************
class ScreenDonationAmount extends GetView<ControllerDonation> {
  const ScreenDonationAmount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChildPageAppBar(title: "Zozo foundation"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image thumbnail =================================================
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Container(
                height: 0.22.sh,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/total_fund_bd.jpg"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(26.r),
                ),
              ),
            ),
            //  Content ========================================================
            donationCardSection(
              title: 'Donate for the survival of kids in Africa',
              organizationName: 'Zazu Foundation',
              donatorImages: [
                'https://randomuser.me/api/portraits/men/1.jpg',
                'https://randomuser.me/api/portraits/women/2.jpg',
                'https://randomuser.me/api/portraits/men/3.jpg',
                'https://randomuser.me/api/portraits/men/4.jpg',
              ],
              donatorCount: 120,
              goalAmount: 2000,
              raisedAmount: 1900,
              description:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Orci nulla sagittis proin faucibus tincidunt...',
              commentsCount: 58,
              onDonatePressed: () {
                Get.toNamed(AppRoutes.donationSuccess);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget donationCardSection({
    required String title,
    required String organizationName,
    required List<String> donatorImages,
    required int donatorCount,
    required int goalAmount,
    required int raisedAmount,
    required String description,
    required int commentsCount,
    required VoidCallback onDonatePressed,
  }) {
    final percentage =
        ((raisedAmount / goalAmount) * 100).clamp(0, 100).toInt();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: goliathsTypography.screenText.copyWith(
              color: goliathsTheme.text,
              fontSize: 18.sp,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.verified, size: 20),
              const SizedBox(width: 8),
              Text(
                organizationName,
                style: goliathsTypography.screenText.copyWith(
                  color: goliathsTheme.text,
                  fontSize: 12.sp,
                  fontFamily: "Roboto",
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Obx(
            () => AmountSelector(
              selectedAmount: controller.selectedAmount.value,
              amounts: [50, 100, 200],
              onSelected: (amount) {
                controller.selectedAmount.value = amount;
              },
            ),
          ),
          SizedBox(height: 36.h),
          CenteredDividerText(text: "or"),
          SizedBox(height: 36.h),
          TextField(
            onChanged: (value) {
              controller.selectedAmount.value = int.tryParse(value) ?? 0;
            },
            decoration: InputDecoration(
              hintText: "Enter Price",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.r),
                borderSide: BorderSide(color: goliathsTheme.stroke),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.r),
                borderSide: BorderSide(color: goliathsTheme.primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.r),
                borderSide: BorderSide(color: goliathsTheme.stroke),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.r,
                vertical: 22.r,
              ),
              hintStyle: goliathsTypography.screenText.copyWith(
                color: goliathsTheme.text.withValues(alpha: 0.4),
              ),
              prefixText: '\$ ',
              prefixStyle: goliathsTypography.screenText.copyWith(
                color: goliathsTheme.text.withValues(alpha: 0.4),
              ),
            ),

            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            style: goliathsTypography.screenText,
            textAlign: TextAlign.center,
          ),
          12.verticalSpace,
          CustomElevatedButton(
            text: "Pay Now",
            onPressed: onDonatePressed,
            isFullWidth: true,
          ),
        ],
      ),
    );
  }
}
