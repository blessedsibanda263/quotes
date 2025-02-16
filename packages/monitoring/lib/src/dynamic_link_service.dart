// Wrapper around [FirebaseDynamicLinks]
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';

typedef onNewDynamicLinkPath = void Function(String newDynamicLinkPath);

class DynamicLinkService {
  static const _domainUriPrefix = 'https://wonderwords1.page.link';
  static const _iOSBundleId = 'com.blessedsibanda263.quotes';
  static const _androidPackageName = 'com.blessedsibanda263.quotes';

  final FirebaseDynamicLinks _dynamicLinks;

  DynamicLinkService({@visibleForTesting FirebaseDynamicLinks? dynamicLinks})
    : _dynamicLinks = dynamicLinks ?? FirebaseDynamicLinks.instance;

  Future<String> generateDynamicLinkUrl({
    required String path,
    SocialMetaTagParameters? socialMetaTagParameters,
  }) async {
    final parameters = DynamicLinkParameters(
      link: Uri.parse('$_domainUriPrefix$path'),
      uriPrefix: _domainUriPrefix,
      androidParameters: const AndroidParameters(
        packageName: _androidPackageName,
      ),
      iosParameters: const IOSParameters(bundleId: _iOSBundleId),
      socialMetaTagParameters: socialMetaTagParameters,
    );
    final shortLink = await _dynamicLinks.buildShortLink(parameters);
    return shortLink.shortUrl.toString();
  }

  Future<String?> getInitialDynamicLinkPath() async {
    final data = await _dynamicLinks.getInitialLink();
    final link = data?.link;
    return link?.path;
  }

  Stream<String> onNewDynamicLinkPath() {
    return _dynamicLinks.onLink.map((PendingDynamicLinkData data) {
      final link = data.link;
      final path = link.path;
      return path;
    });
  }
}
