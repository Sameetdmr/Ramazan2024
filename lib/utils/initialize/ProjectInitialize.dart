import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kartal/kartal.dart';
import 'package:logger/logger.dart';
import 'package:ramadan/core/config/app_environment.dart';
import 'package:ramadan/firebase_options.dart';
import 'package:ramadan/utils/servicelocator/ServiceLocator.dart';

@immutable
final class ProjectInitialize {
  Future<void> make() async {
    WidgetsFlutterBinding.ensureInitialized();
    ServiceLocator().init();

    await runZonedGuarded<Future<void>>(_initialize, (error, stack) {
      Logger().e(error, stackTrace: stack);
      if (!kDebugMode) {
        unawaited(
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
        );
      }
    });
  }

  Future<void> _initialize() async {
    await _initializeFirebase();
    await _initializeGoogleSignIn();
    await DeviceUtility.instance.initPackageInfo();
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await initializeDateFormatting('tr_TR');

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      Logger().e(details.exceptionAsString(), stackTrace: details.stack);
      if (!kDebugMode) {
        unawaited(
          FirebaseCrashlytics.instance.recordFlutterFatalError(details),
        );
      }
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      Logger().e(error, stackTrace: stack);
      if (!kDebugMode) {
        unawaited(
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
        );
      }
      return true;
    };
  }

  Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } on UnsupportedError catch (error, stack) {
      if (AppEnvironment.allowFirebaseInitFailure) {
        Logger().w('Firebase skipped on this platform: $error');
        return;
      }
      Error.throwWithStackTrace(error, stack);
    } catch (error, stack) {
      if (AppEnvironment.allowFirebaseInitFailure) {
        Logger().w('Firebase init failed: $error');
        return;
      }
      Error.throwWithStackTrace(error, stack);
    }
  }

  Future<void> _initializeGoogleSignIn() async {
    try {
      await GoogleSignIn.instance.initialize();
    } catch (error, stack) {
      if (AppEnvironment.isDebug) {
        Logger().w('Google Sign-In init skipped: $error');
        return;
      }
      Error.throwWithStackTrace(error, stack);
    }
  }
}
