import 'package:bike_buddy/pages/ride_page.dart';
import 'package:bike_buddy/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/l10n.dart';
import 'pages/main_page.dart';

void main() {
  runApp(const BikeBuddy());
}

class BikeBuddy extends StatelessWidget {
  const BikeBuddy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BikeBuddy',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/ride': (context) => RidePage(),
        '/settings': (context) => SettingsPage(),
      },
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
    );
  }
}
