import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quotes/l10n/app_localizations.dart';
import 'package:routemaster/routemaster.dart';

class TabContainerScreen extends StatelessWidget {
  const TabContainerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tabState = CupertinoTabPage.of(context);

    return CupertinoTabScaffold(
      controller: tabState.controller,
      tabBuilder: tabState.tabBuilder,
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.format_quote),
            label: l10n.quotesBottomNavigationBarItemLabel,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: l10n.profileBottomNavigationBarItemLabel,
          ),
        ],
      ),
    );
  }
}
