import 'package:bike_buddy/pages/settings/settings_page.dart';
<<<<<<< HEAD
import 'package:bike_buddy/pages/trip_history.dart';
=======
>>>>>>> e787163 (Conflicts & fixes)
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BBDrawerListTile extends ListTile {
  final String text;

  BBDrawerListTile(BuildContext context, this.text, {super.key})
      : super(
            title: Center(
                child: Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(text: text[0], style: const TextStyle(color: Colors.red)),
          TextSpan(text: text.substring(1))
        ]))));
}

class BBDrawerTextButton extends TextButton {
  final String text;
  final String navigateTo;

  BBDrawerTextButton(BuildContext context, this.text, this.navigateTo,
      {super.key})
      : super(
            onPressed: () => {Navigator.pushNamed(context, navigateTo)},
            child: BBDrawerListTile(context, text));
}

class BBDrawer extends Drawer {
  BBDrawer(BuildContext context, {super.key})
      : super(
            child: ListView(padding: EdgeInsets.zero, children: [
          const DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/drawer_header.jpeg"),
                      fit: BoxFit.cover)),
              child: Text("Menu")),
          BBDrawerTextButton(context, AppLocalizations.of(context)!.m_path,
              TripHistoryPage.routeName),
          BBDrawerTextButton(
              context, AppLocalizations.of(context)!.m_history, ""),
          BBDrawerTextButton(
              context, AppLocalizations.of(context)!.m_achievements, ""),
          BBDrawerTextButton(context, AppLocalizations.of(context)!.m_settings,
              SettingsPage.routeName)
        ]));
}
