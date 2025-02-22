import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:quote_details/quote_details.dart';
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

  static String get idPathParameter => 'id';

  static String quoteDetailsPath({int? quoteId}) =>
      '$quoteListPath/${quoteId ?? ':$idPathParameter'}';
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
            final navigation = routerDelegate.push<Quote?>(
              _PathConstants.quoteDetailsPath(quoteId: id),
            );
            return navigation.result;
          },
        ),
      );
    },
    _PathConstants.quoteDetailsPath():
        (info) => MaterialPage(
          child: QuoteDetailsScreen(
            quoteId: int.parse(
              info.pathParameters[_PathConstants.idPathParameter] ?? '',
            ),
            onAuthenticationError: () {
              routerDelegate.push(_PathConstants.signUpPath);
            },
            quoteRepository: quoteRepository,
            shareableLinkGenerator: (quote) {
              return Future.value('Sharing ${quote.body}');
            },
          ),
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
