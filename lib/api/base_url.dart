// Centralized API base URL configuration.
// Change this value to point the app to a different backend.

/// Default base URL used across the app for API requests.
///
/// This value is read from the compile-time environment variable
/// `BASE_URL` when provided (via `--dart-define=BASE_URL=...`). If the
/// variable is not provided the fallback `'http://localhost:8000'` is used.
///
/// Example (debug/run):
///   flutter run --dart-define=BASE_URL=https://api.example.com
/// Example (build):
///   flutter build apk --dart-define=BASE_URL=https://api.example.com
const String kDefaultBaseUrl = String.fromEnvironment(
  'BASE_URL',
  defaultValue: 'https://web-py-new-feature.75789.top',
);
