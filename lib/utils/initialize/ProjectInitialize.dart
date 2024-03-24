// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kartal/kartal.dart';
import 'package:logger/logger.dart';
import 'package:ramadan/firebase_options.dart';
import 'package:ramadan/utils/servicelocator/ServiceLocator.dart';

@immutable
final class ProjectInitialize {
  Future<void> make() async {
    WidgetsFlutterBinding.ensureInitialized();

    await runZonedGuarded<Future<void>>(_initialize, (error, stack) {
      Logger().e(error);
    });
    ServiceLocator().init();
  }

  Future<void> _initialize() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await DeviceUtility.instance.initPackageInfo(); // System data read or kartal package
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await initializeDateFormatting('tr_TR');

    FlutterError.onError = (FlutterErrorDetails details) async {
      await FirebaseCrashlytics.instance.log('${StackTrace.current} / ${details.exceptionAsString()}');
      await FirebaseCrashlytics.instance.recordError(details.exceptionAsString(), StackTrace.current, printDetails: true, fatal: true);
      Logger().e(details.exceptionAsString());
      exit(1);
    };
  }
}
