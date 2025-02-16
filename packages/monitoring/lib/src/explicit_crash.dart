import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class ExplicitCrash {
  final FirebaseCrashlytics _crashlytics;

  ExplicitCrash({@visibleForTesting FirebaseCrashlytics? crashlytics})
    : _crashlytics = crashlytics ?? FirebaseCrashlytics.instance;

  crashTheApp() {
    _crashlytics.crash();
  }
}
