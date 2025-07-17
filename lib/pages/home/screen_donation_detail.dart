part of '../_pages.dart';

/// ****************************************************************************
/// Screen donation detail of organization
/// ****************************************************************************

class ScreenDonationDetail extends StatelessWidget {
  const ScreenDonationDetail({super.key});

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
              commentsCount: 58, onDonatePressed: () {
                Get.toNamed(AppRoutes.donationAmount);
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
    final percentage = ((raisedAmount / goalAmount) * 100).clamp(0, 100).toInt();

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
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: List.generate(
                  donatorImages.length,
                      (index) => Padding(
                    padding: EdgeInsets.only(left: index * 22.h),
                    child: Container(
                      padding: EdgeInsets.all(2.h),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: Image.network(
                          donatorImages[index],
                          height: 30.h,
                          width: 30.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '$donatorCount+ donated',
                style: goliathsTypography.screenText.copyWith(
                  color: goliathsTheme.text.withValues(alpha: 0.4),
                  fontSize: 12.sp,
                  fontFamily: "Roboto",
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Goals: \$${goalAmount.toString()}',
                style: goliathsTypography.screenText.copyWith(
                  color: goliathsTheme.text,
                  fontSize: 14.sp,
                  fontFamily: "Roboto",
                ),
              ),
              const Spacer(),
              Text(
                'Raised: \$${raisedAmount.toString()} ($percentage%)',
                style: goliathsTypography.screenText.copyWith(
                  color: goliathsTheme.accent,
                  fontSize: 14.sp,
                  fontFamily: "Roboto",
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Description',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: goliathsTheme.accent,
              fontFamily: "Poppins",
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 12),
          Text(
            description.length > 100
                ? '${description.substring(0, 100)}...'
                : description,
            style: goliathsTypography.screenText.copyWith(
              fontSize: 13.sp,
              color: goliathsTheme.text.withValues(alpha: 0.7),
            ),
          ),
          if (description.length > 100)
            Text(
              'Read more',
              style: goliathsTypography.screenText.copyWith(
                color: goliathsTheme.accent,
                fontSize: 13.sp,
              ),
            ),
          48.verticalSpace,
          CustomElevatedButton(
            text: "Donate",
            onPressed: onDonatePressed,
            isFullWidth: true,
          ),
        ],
      ),
    );
  }
}

