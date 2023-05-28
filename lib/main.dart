import 'package:bike_buddy/hive/adapters/position_adapter.dart';
import 'package:bike_buddy/hive/entities/ride_record.dart';
import 'package:bike_buddy/constants/theme.dart';
import 'package:bike_buddy/hive/adapters/standard_duration_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:bike_buddy/pages/main_page.dart';
import 'package:bike_buddy/pages/ride/ride_page.dart';
import 'package:bike_buddy/pages/ride_details_page.dart';
import 'package:bike_buddy/pages/trip_history.dart';
import 'package:bike_buddy/pages/user_page.dart';
import 'package:bike_buddy/pages/settings/settings_page.dart';
import 'package:bike_buddy/utils/settings_manager.dart';
import 'package:bike_buddy/utils/l10n/l10n.dart';
import 'package:bike_buddy/utils/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStorageService.init();

  await Hive.initFlutter();
  Hive.registerAdapter(PositionRecordAdapter());
  Hive.registerAdapter(RideRecordAdapter());
  Hive.registerAdapter(DurationAdapter());
  Hive.registerAdapter(StandardDurationAdapter());
  Hive.registerAdapter(PositionAdapter());
  
  await Hive.openBox('ride_records');

  print(kBBLightTheme.colorScheme.toString());
  runApp(ChangeNotifierProvider(
    create: (context) => SettingsManager(),
    child: const BikeBuddy(),
  ));
}

class BikeBuddy extends StatelessWidget {
  const BikeBuddy({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsManager>();
    return MaterialApp(
      title: 'BikeBuddy',
      debugShowCheckedModeBanner: false,
      theme: kBBLightTheme,
      darkTheme: kBBDarkTheme,
      themeMode: settings.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      routes: {
        '/': (context) => const MainPage(),
        RidePage.routeName: (context) => const RidePage(),
        UserPage.routeName: (context) => const UserPage(),
        SettingsPage.routeName: (context) => const SettingsPage(),
        TripHistoryPage.routeName: (context) => const TripHistoryPage(),
        RideDetailsPage.routeName: (context) => const RideDetailsPage(),
      },
      supportedLocales: L10n.all,
      locale: Locale(settings.applicationLanguage),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
