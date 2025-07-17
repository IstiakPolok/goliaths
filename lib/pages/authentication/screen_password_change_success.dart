part of '../_pages.dart';

/// ****************************************************************************
/// Password change success page
/// ****************************************************************************
class ScreenPasswordChangeSuccess extends StatelessWidget {
  const ScreenPasswordChangeSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  "assets/icons/check_medium.svg",
                  height: 60.h,
                  width: 60.h,
                ),
                24.verticalSpace,
                Text(
                  "Password Change\nSuccessfully",
                  style: goliathsTypography.screenHeading.copyWith(
                    color: goliathsTheme.textOnPrimary,
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
                    text: "Back To Login",
                    onPressed: () {},
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
