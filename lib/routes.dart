import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:goliaths/pages/_pages.dart';
import 'package:goliaths/theme.dart';

class AppRoutes extends StatelessWidget {
  const AppRoutes({super.key});

  /*==========================================================================*/
  static const String splash = "/";
  static const String onboard = "/onboard";
  static const String country = "/country";
  static const String avatarDetail = "/avatar";
  static const String aiType = "/aiType";
  static const String dob = "/dob";

  static const String auth = "/auth";
  static const String login = "/login";
  static const String register = "/register";
  static const String createPass = "/createPass";
  static const String verifyEmail = "/verifyEmail";
  static const String verifyOtp = "/verifyOtp";
  static const String passChangeSuccess = "/passChangeSuccess";
  static const String home = "/home";
  static const String chat = "/chat";
  static const String chatHistory = "/chatHistory";
  static const String settings = "/settings";
  static const String profile = "/profile";
  static const String subscription = "/subscription";
  static const String faq = "/faq";
  static const String terms = "/terms";
  static const String privacy = "/privacy";
  static const String birthDate = "/birthDate";
  static const String friendsBirth = "/friendsBirth";
  static const String birthWish = "/birthWish";
  static const String donationHome = "/donationHome";
  static const String donationDetail = "/donationDetail";
  static const String donationAmount = "/donationAmount";
  static const String donationSuccess = "/donationSuccess";

  /*==========================================================================*/
  static List<GetPage<dynamic>> routeList = [
    GetPage(
      name: splash,
      page: () => ScreenSplash(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: onboard,
      page: () => ScreenAvatarList(),
      binding: _provide(ControllerOnboard(), true),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: avatarDetail,
      page: () => ScreenAvatarDetail(),
      binding: _provide(ControllerOnboard(), true),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: aiType,
      page: () => ScreenAiType(),
      // binding: _provide(ControllerOnboard(), true),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: country,
      page: () => ScreenCountry(),
      binding: _provide(ControllerOnboard(), true),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: dob,
      page: () => ScreenDob(),
      binding: _provide(ControllerOnboard(), true),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: auth,
      page: () => ScreenAuthEntry(),
      transition: Transition.rightToLeft,
      // binding: _provide(ControllerOnboard()),
    ),
    GetPage(
      name: login,
      page: () => ScreenLogin(),
      transition: Transition.rightToLeft,
      // binding: _provide(ControllerOnboard()),
    ),
    GetPage(
      name: register,
      page: () => ScreenRegister(),
      transition: Transition.rightToLeft,
      // binding: _provide(ControllerOnboard()),
    ),
    GetPage(
      name: createPass,
      page: () => ScreenCreatePassword(),
      transition: Transition.rightToLeft,
      // binding: _provide(ControllerOnboard()),
    ),
    GetPage(
      name: verifyEmail,
      page: () => ScreenVerifyEmail(),
      transition: Transition.rightToLeft,
      // binding: _provide(ControllerOnboard()),
    ),
    GetPage(
      name: verifyOtp,
      page: () => ScreenVerifyOtp(),
      transition: Transition.rightToLeft,
      // binding: _provide(ControllerOnboard()),
    ),
    GetPage(
      name: passChangeSuccess,
      page: () => ScreenPasswordChangeSuccess(),
      transition: Transition.rightToLeft,
      // binding: _provide(ControllerOnboard()),
    ),

    GetPage(
      name: home,
      page: () => ScreenHome(),
      transition: Transition.rightToLeft,
      // binding: _provide(ControllerOnboard()),
    ),
    GetPage(
      name: chat,
      page: () => ScreenChat(),
      binding: _provide(ControllerHome()),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: chatHistory,
      page: () => ScreenHistory(),
      binding: _provide(ControllerHistory()),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: settings,
      page: () => ScreenSettings(),
      transition: Transition.rightToLeft,
      // binding: _provide(ControllerHome()),
    ),
    GetPage(
      name: profile,
      page: () => ScreenProfile(),
      transition: Transition.rightToLeft,
      // binding: _provide(ControllerHome()),
    ),
    GetPage(
      name: subscription,
      page: () => ScreenSubscription(),
      binding: _provide(ControllerSubscription()),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: terms,
      page: () => ScreenTermsCondition(),
      binding: _provide(ControllerTerms()),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: privacy,
      page: () => ScreenPrivacyPolicy(),
      binding: _provide(ControllerPrivacy()),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: faq,
      page: () => ScreenFaq(),
      transition: Transition.rightToLeft,
      // binding: _provide(ControllerPrivacy()),
    ),
    GetPage(
      name: birthDate,
      page: () => ScreenBirthdate(),
      transition: Transition.rightToLeft,
      // binding: _provide(ControllerPrivacy()),
    ),
    GetPage(
      name: friendsBirth,
      page: () => ScreenFriendsBirth(),
      transition: Transition.rightToLeft,
      binding: _provide(ControllerBirthDay()),
    ),
    GetPage(
      name: birthWish,
      page: () => ScreenBirthdayWish(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: donationHome,
      page: () => ScreenDonationHome(),
      binding: _provide(ControllerDonation()),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: donationDetail,
      page: () => ScreenDonationDetail(),
      transition: Transition.rightToLeft,
      // binding: _provide(ControllerDonation()),
    ),
    GetPage(
      name: donationAmount,
      page: () => ScreenDonationAmount(),
      transition: Transition.rightToLeft,
      binding: _provide(ControllerDonation()),
    ),
    GetPage(
      name: donationSuccess,

      page: () => ScreenDonationComplete(),
      transition: Transition.rightToLeft,
      // binding: _provide(ControllerDonation()),
    ),
  ];

  /*==========================================================================*/
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: routeList,
        theme: createGoliathsTheme(context),
        defaultTransition: Transition.rightToLeft,
        transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }

  /*==========================================================================*/
  static Bindings _provide<T>(T item, [bool fenix = false]) {
    return BindingsBuilder(() => Get.lazyPut(() => item, fenix: fenix));
  }
}
