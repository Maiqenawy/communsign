class UserSession {
  static String token = "";
  static bool isGuest = false;

  static bool get isLoggedIn => token.isNotEmpty;
}
