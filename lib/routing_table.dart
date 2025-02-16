import 'package:flutter/material.dart';
import 'package:monitoring/monitoring.dart';
import 'package:quote_repository/quote_repository.dart';
import 'package:quotes/tab_container_screen.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sign_up/sign_up.dart';
import 'package:user_repository/user_repository.dart';

class _PathConstants {
  const _PathConstants._();

  static String get tabContainerPath => '/';
  static String get quoteListPath => '${tabContainerPath}quotes';
  static String get profileMenuPath => '${tabContainerPath}user';
  static String get signUpPath => '${tabContainerPath}sign-up';
}

Map<String, PageBuilder> buildRoutingTable({
  required RoutemasterDelegate routerDelegate,
  required UserRepository userRepository,
  required QuoteRepository quoteRepository,
  required RemoteValueService remoteValueService,
  required DynamicLinkService dynamicLinkService,
}) {
  return {
    _PathConstants.tabContainerPath:
        (_) => CupertinoTabPage(
          child: const TabContainerScreen(),
          paths: [_PathConstants.quoteListPath, _PathConstants.profileMenuPath],
        ),
    _PathConstants.signUpPath:
        (_) => MaterialPage(
          child: SignUpScreen(
            userRepository: userRepository,
            onSignUpSuccess: () {},
          ),
        ),
  };
}
