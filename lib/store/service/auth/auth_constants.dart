class AuthConstants {
  AuthConstants._();

  // Storage keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String accessTokenExpKey = 'access_token_exp_text';
  static const String stopRefreshKey = 'stop_refresh';

  // Token refresh advance time (60 seconds before expiration)
  static const Duration tokenRefreshAdvanceTime = Duration(seconds: 60);
}
