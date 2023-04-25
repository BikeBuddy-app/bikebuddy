import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bike_buddy/components/drawer/bb_drawer_button.dart';
import 'package:bike_buddy/pages/trip_history.dart';
import 'package:bike_buddy/pages/user_page.dart';
import 'package:bike_buddy/pages/settings/settings_page.dart';

class BBDrawer extends StatelessWidget {
  const BBDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
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
          DrawerButton(
            AppLocalizations.of(context)!.m_history,
            TripHistoryPage.routeName,
          ),
          DrawerButton(
            AppLocalizations.of(context)!.m_user,
            UserPage.routeName,
          ),
          DrawerButton(
            AppLocalizations.of(context)!.m_settings,
            SettingsPage.routeName,
          ),
        ],
      ),
    );
  }
}
