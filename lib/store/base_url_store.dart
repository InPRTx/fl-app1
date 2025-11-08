import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseUrlStore extends ChangeNotifier {
  static final BaseUrlStore _instance = BaseUrlStore._internal();

  factory BaseUrlStore() => _instance;

  BaseUrlStore._internal();

  static const String _kKeyBaseUrl = 'app_base_url';

  /// Default base URL from environment or fallback
  static const String _kDefaultBaseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://web-py-new-feature.75789.top',
  );

  SharedPreferences? _prefs;

  /// Custom base URL set by user, null if using default
  String? _customBaseUrl;

  /// Get the effective base URL (custom if set, otherwise default)
  String get baseUrl => _customBaseUrl ?? _kDefaultBaseUrl;

  /// Get the default base URL (from environment)
  String get defaultBaseUrl => _kDefaultBaseUrl;

  /// Check if using custom base URL
  bool get isUsingCustom => _customBaseUrl != null;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _customBaseUrl = _prefs?.getString(_kKeyBaseUrl);
    notifyListeners();
  }

  Future<void> setCustomBaseUrl(String? url) async {
    if (url == null || url.isEmpty || url == _kDefaultBaseUrl) {
      _customBaseUrl = null;
      await _prefs?.remove(_kKeyBaseUrl);
    } else {
      _customBaseUrl = url;
      await _prefs?.setString(_kKeyBaseUrl, url);
    }
    notifyListeners();
  }

  Future<void> resetToDefault() async {
    await setCustomBaseUrl(null);
  }
}
