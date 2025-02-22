import 'package:flutter/material.dart';
import 'package:quote_list/quote_list.dart';
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
  static String get signUpPath => '${tabContainerPath}sign_up';
}

Map<String, PageBuilder> buildRoutingTable({
  required RoutemasterDelegate routerDelegate,
  required UserRepository userRepository,
  required QuoteRepository quoteRepository,
}) {
  return {
    _PathConstants.tabContainerPath:
        (_) => CupertinoTabPage(
          child: const TabContainerScreen(),
          paths: [_PathConstants.quoteListPath, _PathConstants.profileMenuPath],
        ),
    _PathConstants.quoteListPath: (route) {
      return MaterialPage(
        name: 'quotes-list',
        child: QuoteListScreen(
          quoteRepository: quoteRepository,
          userRepository: userRepository,
          onAuthenticationError: (context) {
            routerDelegate.push(_PathConstants.signUpPath);
          },
          onQuoteSelected: (id) {
            print("Quote Selected: $id");
            return Future.value(null);
          },
        ),
      );
    },
    _PathConstants.signUpPath:
        (_) => MaterialPage(
          child: SignUpScreen(
            userRepository: userRepository,
            onSignUpSuccess: () {},
          ),
        ),
  };
}
