// Wrapper around [FirebaseRemoteConfig]
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class RemoteValueService {
  static const _gridQuotesViewEnabledKey = 'grid_quotes_view_enabled';

  final FirebaseRemoteConfig _remoteConfig;

  RemoteValueService({@visibleForTesting FirebaseRemoteConfig? remoteConfig})
    : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

  Future<void> load() async {
    await _remoteConfig.setDefaults(<String, dynamic>{
      _gridQuotesViewEnabledKey: true,
    });
    await _remoteConfig.fetchAndActivate();
  }

  bool get isGridQuotesViewEnabled =>
      _remoteConfig.getBool(_gridQuotesViewEnabledKey);
}
