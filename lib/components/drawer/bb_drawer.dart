import 'package:bike_buddy/constants/default_values.dart' as default_values;
import 'package:bike_buddy/pages/intro/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bike_buddy/components/drawer/bb_drawer_button.dart';
import 'package:bike_buddy/pages/trip_history.dart';
import 'package:bike_buddy/pages/user_page.dart';
import 'package:bike_buddy/pages/settings/settings_page.dart';

class BBDrawer extends StatelessWidget {
  const BBDrawer({super.key});

  List<Widget> buildMenuItems(BuildContext context) {
    List<Widget> menuItems = [
      DrawerHeader(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/drawer_header.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Text(
          "Menu",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
        ),
      ),
      BBDrawerButton(
        AppLocalizations.of(context)!.m_history,
        TripHistoryPage.routeName,
      ),
      BBDrawerButton(
        AppLocalizations.of(context)!.m_user,
        UserPage.routeName,
      ),
      BBDrawerButton(
        AppLocalizations.of(context)!.m_settings,
        SettingsPage.routeName,
      ),
    ];
    if (default_values.debugInfo) {
      menuItems.add(
        const BBDrawerButton(
          "Ondoarding [D]",
          OnboardingScreen.routeName
        )
      );
    }
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: buildMenuItems(context),
      ),
    );
  }
}
