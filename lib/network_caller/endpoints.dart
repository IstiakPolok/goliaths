class Urls {
  static const String baseUrl = 'http://10.10.13.16:100/api';

  static const String login = '$baseUrl/auth/login/';
  static const String signup = '$baseUrl/auth/signup/';
  static const String signupotp = '$baseUrl/auth/send-verification-otp/';
  static const String signupotpverify = '$baseUrl/auth/verify-account/';
  static const String aimodeseletion = '$baseUrl/conversations/select_mode/';

  static const String profileupdate = '$baseUrl/auth/profile/';

  static const String authentication = '$baseUrl/auth/verify-auth';
  static const String logout = '$baseUrl/auth/logout';
}
