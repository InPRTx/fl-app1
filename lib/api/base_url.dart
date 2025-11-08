// Centralized API base URL configuration.
// Change this value to point the app to a different backend.

import 'package:fl_app1/store/base_url_store.dart';

/// Default base URL used across the app for API requests.
///
/// This value is managed by [BaseUrlStore] which supports:
/// - Reading from shared_preferences for custom user-defined URLs
/// - Falling back to compile-time environment variable `BASE_URL`
/// - Using hardcoded default if no environment variable is set
///
/// To customize the base URL:
/// 1. Navigate to /system/debug/base_url in the app
/// 2. Or use compile-time flag: flutter run --dart-define=BASE_URL=https://api.example.com
///
/// Access the current base URL via: `BaseUrlStore().baseUrl`
String get kDefaultBaseUrl => BaseUrlStore().baseUrl;
