import 'dart:async';
import 'dart:isolate';

import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:fav_qs_api/fav_qs_api.dart';
import 'package:flutter/material.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:monitoring/monitoring.dart';
import 'package:quote_repository/quote_repository.dart';
import 'package:quotes/l10n/app_localizations.dart';
import 'package:quotes/routing_table.dart';
import 'package:quotes/screen_view_observer.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sign_up/sign_up.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  late final errorReportingService = ErrorReportingService();

  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await initializeMonitoringPackage();

      final remoteValueService = RemoteValueService();
      await remoteValueService.load();

      FlutterError.onError = errorReportingService.recordFlutterError;

      Isolate.current.addErrorListener(
        RawReceivePort((pair) async {
          final List<dynamic> errorAndStacktrace = pair;
          await errorReportingService.recordError(
            errorAndStacktrace.first,
            errorAndStacktrace.last,
          );
        }).sendPort,
      );

      runApp(Quotes(remoteValueService: remoteValueService));
    },
    (error, stack) =>
        errorReportingService.recordError(error, stack, fatal: true),
  );
}

class Quotes extends StatefulWidget {
  final RemoteValueService remoteValueService;

  const Quotes({super.key, required this.remoteValueService});

  @override
  State<Quotes> createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  final _keyValueStorage = KeyValueStorage();
  final _analyticsService = AnalyticsService();
  final _dynamicLinkService = DynamicLinkService();
  late final FavQsApi _favQsApi = FavQsApi(
    userTokenSupplier: () => _userRepository.getUserToken(),
  );
  late final QuoteRepository _quoteRepository = QuoteRepository(
    keyValueStorage: _keyValueStorage,
    remoteApi: _favQsApi,
  );
  late final _userRepository = UserRepository(
    noSqlStorage: _keyValueStorage,
    remoteApi: _favQsApi,
  );
  late final RoutemasterDelegate _routerDelegate = RoutemasterDelegate(
    observers: [ScreenViewObserver(analyticsService: _analyticsService)],
    routesBuilder: (context) {
      return RouteMap(
        routes: buildRoutingTable(
          routerDelegate: _routerDelegate,
          userRepository: _userRepository,
          quoteRepository: _quoteRepository,
          remoteValueService: widget.remoteValueService,
          dynamicLinkService: _dynamicLinkService,
        ),
      );
    },
  );
  final _lightTheme = LightAppThemeData();
  final _darkTheme = DarkAppThemeData();
  late StreamSubscription _incomingDynamicLinksSubscription;

  @override
  void initState() {
    super.initState();
    _openInitialDynamicLinkIfAny();
    _incomingDynamicLinksSubscription = _dynamicLinkService
        .onNewDynamicLinkPath()
        .listen(_routerDelegate.push);
  }

  Future<void> _openInitialDynamicLinkIfAny() async {
    final path = await _dynamicLinkService.getInitialDynamicLinkPath();
    if (path != null) {
      _routerDelegate.push(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _userRepository.getDarkModePreference(),
      builder: (context, snapshot) {
        final DarkModePreference? darkModePreference = snapshot.data;
        return AppTheme(
          lightTheme: _lightTheme,
          darkTheme: _darkTheme,
          child: MaterialApp.router(
            theme: _lightTheme.materialThemeData,
            darkTheme: _darkTheme.materialThemeData,
            themeMode: darkModePreference?.toThemeMode(),
            supportedLocales: const [Locale('en', ''), Locale('pt', 'BR')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              ComponentLibraryLocalizations.delegate,
              SignUpLocalizations.delegate,
            ],
            routerDelegate: _routerDelegate,
            routeInformationParser: const RoutemasterParser(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _incomingDynamicLinksSubscription.cancel();
    super.dispose();
  }
}

extension on DarkModePreference {
  ThemeMode toThemeMode() {
    switch (this) {
      case DarkModePreference.useSystemSettings:
        return ThemeMode.system;
      case DarkModePreference.alwaysDark:
        return ThemeMode.dark;
      case DarkModePreference.alwaysLight:
        return ThemeMode.light;
    }
  }
}
