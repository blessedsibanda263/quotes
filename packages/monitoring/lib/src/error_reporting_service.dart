import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

// Wrapoer around [FirebaseCrashlytics]
class ErrorReportingService {
  final FirebaseCrashlytics _crashlytics;

  ErrorReportingService({@visibleForTesting FirebaseCrashlytics? crashlytics})
    : _crashlytics = crashlytics ?? FirebaseCrashlytics.instance;

  Future<void> recordFlutterError(FlutterErrorDetails flutterErrorDetails) {
    return _crashlytics.recordFlutterError(flutterErrorDetails);
  }

  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    bool fatal = false,
  }) {
    return _crashlytics.recordError(exception, stack, fatal: fatal);
  }
}
