part of '../_pages.dart';

/// ****************************************************************************
/// Splash screen
/// ****************************************************************************
class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () async {
      String? token = await SharedPreferencesHelper.getAccessToken();

      if (token != null && token.isNotEmpty) {
        // Redirect to the main screen (e.g., Bottom Navbar or Home)
        Get.offAllNamed(AppRoutes.home);
      } else {
        // Redirect to the Welcome Screen if no token is found
        Get.offAllNamed(AppRoutes.auth);
      }

      // You can replace this with any screen you want to navigate to
      //Get.offAllNamed(AppRoutes.auth);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Center(
          child: Image.asset(
            "assets/images/logo_splash.png",
            width: 0.7.sw,
            height: 0.7.sw,
          ),
        ),
      ),
    );
  }
}
