import 'package:flutter/foundation.dart';

/// Runtime flags for local development without full Firebase setup.
abstract final class AppEnvironment {
  static bool get isDebug => kDebugMode;

  /// When true, Firebase Remote Config version checks always pass.
  static bool get relaxVersionCheck => isDebug;

  /// When true, Firebase init failures are logged but do not stop the app.
  static bool get allowFirebaseInitFailure => isDebug && kIsWeb;
}
