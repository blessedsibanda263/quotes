// Wrapper around [FirebaseAnalytics]
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics;

  AnalyticsService({@visibleForTesting FirebaseAnalytics? analytics})
    : _analytics = analytics ?? FirebaseAnalytics.instance;

  Future<void> setCurrentScreen(String screenName) {
    return _analytics.logScreenView(screenName: screenName);
  }

  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) {
    return _analytics.logEvent(name: name, parameters: parameters);
  }
}
