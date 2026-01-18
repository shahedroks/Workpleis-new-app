/// Base API URL (must include scheme + host).
///
/// Example:
/// - https://api.example.com
/// - https://api.example.com/api
///
/// You can override this at build/run time using:
/// `--dart-define=API_BASE_URL=https://api.example.com`
const String api = String.fromEnvironment('API_BASE_URL', defaultValue: 'z');