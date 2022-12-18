import 'package:bike_buddy/components/bike_buddy_bar.dart';
import 'package:bike_buddy/pages/settings/settings_screen_notifier.dart';
import 'package:bike_buddy/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/general_constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = true;
  bool _functionality = true;
  String _distanceUnit = "kilometer";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: Center(
            child: Column(children: [
          Consumer<SettingsScreenNotifier>(
              builder: (context, notifier, child) {
            var translations = AppLocalizations.of(context);
            return SettingsList(
              shrinkWrap: true,
              sections: [
                SettingsSection(
                  title: Text(translations!.m_settings),
                  tiles: [
                    SettingsTile.navigation(
                      leading: Icon(Icons.language),
                      title: Text(translations.language_title),
                      value: Text(translations.language),
                      onPressed: (BuildContext context) {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: L10n.languages
                                      .map((language) => ListTile(
                                            title: Text(
                                                language['name'].toString()),
                                            onTap: () {
                                              notifier.updateApplicationLanguage(language['code'].toString());
                                              Navigator.pop(context);
                                            },
                                          ))
                                      .toList()
                                  );
                            });
                      },
                    ),
                    SettingsTile.switchTile(
                      onToggle: (value) {
                        setState(() => _notifications = value);
                      },
                      initialValue: _notifications,
                      leading: Icon(Icons.notifications),
                      title: Text(translations.set_notifications),
                    ),
                    SettingsTile.switchTile(
                      onToggle: (value) {
                        notifier.toggleApplicationTheme(value);
                      },
                      initialValue: notifier.isDarkModeEnabled,
                      leading: Icon(Icons.nightlight),
                      title: Text(translations.set_darkmode),
                    ),
                    SettingsTile.switchTile(
                      onToggle: (value) {
                        setState(() => _functionality = value);
                      },
                      initialValue: _functionality,
                      leading: Icon(Icons.ac_unit_sharp),
                      title: Text(translations.set_placeholder),
                    ),
                    SettingsTile.navigation(
                      leading: Icon(Icons.edit_road),
                      title: Text(translations.set_distance_unit),
                      value: Text(_distanceUnit),
                      onPressed: (BuildContext context) {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: SUPPORTED_DISTANCE_UNITS
                                      .map((unit) => ListTile(
                                    title: Text( unit ),
                                    onTap: () {
                                      setState(() => _distanceUnit = unit);
                                      Navigator.pop(context);
                                    },
                                  )).toList()
                              );
                            });
                      },
                    ),
                  ],
                ),
              ],
            );
          })
          // ]
        ])));
  }
}
