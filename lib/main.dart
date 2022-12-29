import 'package:bike_buddy/pages/ride_page.dart';
import 'package:bike_buddy/pages/settings/settings_page.dart';
import 'package:bike_buddy/pages/settings/settings_screen_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '/utils/l10n/l10n.dart';
import 'pages/main_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => SettingsScreenNotifier(),
        child: const BikeBuddy())
  );

}

class BikeBuddy extends StatelessWidget {
  const BikeBuddy({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsScreenNotifier>(
        builder: (context, notifier, child) {
          return MaterialApp(
            title: 'BikeBuddy',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData.dark(),
            themeMode: notifier.isDarkModeEnabled ? ThemeMode.dark : ThemeMode
                .light,
            initialRoute: '/',
            routes: {
              '/': (context) => MainPage(),
              '/ride': (context) => RidePage(),
              '/settings': (context) => SettingsPage(),
            },
            supportedLocales: L10n.all,
            locale: Locale(notifier.applicationLanguage),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
          );
        });
  }
}
