part of '../_pages.dart';

/// ****************************************************************************
/// Donation complete screen
/// ****************************************************************************
class ScreenDonationComplete extends StatelessWidget {
  const ScreenDonationComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChildPageAppBar(title: ""),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/check_large.png",
                  height: 100.h,
                  width: 100.h,
                ),
                24.verticalSpace,
                Text(
                  "Thank You!\nPayment Completed",
                  style: goliathsTypography.screenHeading.copyWith(
                    color: goliathsTheme.text,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 0.7.sw,
                  child: CustomElevatedButton(
                    text: "Home",
                    onPressed: () {
                      Get.toNamed(AppRoutes.home);
                    },
                    isFullWidth: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
