import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:bike_buddy/constants/general_constants.dart';
import 'package:bike_buddy/components/bb_appbar.dart';
import 'package:bike_buddy/pages/settings/settings_screen_notifier.dart';
import 'package:bike_buddy/utils/l10n/l10n.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const String routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _distanceUnit = "kilometer";
  bool _functionality = true;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BBAppBar(),
      body: Center(
        child: Column(
          children: [
            Consumer<SettingsScreenNotifier>(
              builder: (context, notifier, child) {
                final translations = AppLocalizations.of(context);
                return SettingsList(
                  shrinkWrap: true,
                  sections: [
                    SettingsSection(
                      title: Text(translations!.m_settings),
                      tiles: [
                        SettingsTile.navigation(
                          leading: const Icon(Icons.language),
                          title: Text(translations.language_title),
                          value: Text(translations.language),
                          onPressed: (BuildContext context) {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: L10n.languages
                                      .map(
                                        (language) => ListTile(
                                          title: Text(
                                            language['name'].toString(),
                                          ),
                                          onTap: () {
                                            notifier.updateApplicationLanguage(
                                              language['code'].toString(),
                                            );
                                            Navigator.pop(context);
                                          },
                                        ),
                                      )
                                      .toList(),
                                );
                              },
                            );
                          },
                        ),
                        SettingsTile.switchTile(
                          initialValue: _notifications,
                          leading: const Icon(Icons.notifications),
                          title: Text(translations.set_notifications),
                          onToggle: (value) {
                            setState(() => _notifications = value);
                          },
                        ),
                        SettingsTile.switchTile(
                          initialValue: notifier.isDarkModeEnabled,
                          leading: const Icon(Icons.nightlight),
                          title: Text(translations.set_darkmode),
                          onToggle: (value) {
                            notifier.toggleApplicationTheme(value);
                          },
                        ),
                        SettingsTile.switchTile(
                          initialValue: _functionality,
                          leading: const Icon(Icons.ac_unit_sharp),
                          title: Text(translations.set_placeholder),
                          onToggle: (value) {
                            setState(() => _functionality = value);
                          },
                        ),
                        SettingsTile.navigation(
                          leading: const Icon(Icons.edit_road),
                          title: Text(translations.set_distance_unit),
                          value: Text(_distanceUnit),
                          onPressed: (BuildContext context) {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: SUPPORTED_DISTANCE_UNITS
                                      .map(
                                        (unit) => ListTile(
                                          title: Text(unit),
                                          onTap: () {
                                            setState(
                                                () => _distanceUnit = unit);
                                            Navigator.pop(context);
                                          },
                                        ),
                                      )
                                      .toList(),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            ), // ]
          ],
        ),
      ),
    );
  }
}
