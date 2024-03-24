// ignore_for_file: one_member_abstracts

import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:ramadan/ui/common/dialogs/CustomDialogWidget.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/exceptions/CustomException.dart';
import 'package:ramadan/utils/popups/CustomDialog.dart';

abstract class IExceptionHandlingService {
  Future<void> handleException(dynamic exception);
}

final class ExceptionHandlingService implements IExceptionHandlingService {
  @override
  Future<void> handleException(dynamic exception) async {
    String dialogMessageKey;

    await FirebaseCrashlytics.instance.log('${StackTrace.current} / ${exception is! CustomException ? exception : exception.message}');
    await FirebaseCrashlytics.instance.setCustomKey('ExceptionType', exception is! CustomException ? 'Exception' : 'CustomException');
    await FirebaseCrashlytics.instance.recordError('${exception is! CustomException ? exception : exception.message}', StackTrace.current, printDetails: true);

    if (exception is! CustomException) {
      dialogMessageKey = StringCommonConstant.anErrorOccured;
    } else {
      dialogMessageKey = exception.message;
    }

    CustomDialog.showCustomDialog(CustomDialogWidget(StringCommonConstant.appName, dialogMessageKey, () => exit(1)));
  }
}
