class Urls {
  static const String baseUrl = 'https://11214f5e4967.ngrok-free.app/api';

  static const String login = '$baseUrl/auth/login/';
  static const String signup = '$baseUrl/auth/signup/';
  static const String signupotp = '$baseUrl/auth/send-verification-otp/';
  static const String signupotpverify = '$baseUrl/auth/verify-account/';
  static const String aimodeseletion = '$baseUrl/conversations/select_mode/';
  static const String chatList = '$baseUrl/conversations/';
  static const String donationSummary = '$baseUrl/donations/summary/';
  static const String donation = '$baseUrl/donations/';
  static const String privacy = '$baseUrl/privacy/';
  static const String terms = '$baseUrl/terms/';
  static const String planlist = '$baseUrl/plans/';
  static const String friends = '$baseUrl/friends/';

  static const String profileupdate = '$baseUrl/auth/profile/';

  static const String authentication = '$baseUrl/auth/verify-auth';
  static const String logout = '$baseUrl/auth/logout';
}
