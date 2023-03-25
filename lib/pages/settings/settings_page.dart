import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:bike_buddy/constants/general_constants.dart';
import 'package:bike_buddy/components/bb_appbar.dart';
import 'package:bike_buddy/utils/settings_manager.dart';
import 'package:bike_buddy/utils/l10n/l10n.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const String routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsManager>();
    final translations = AppLocalizations.of(context);
    return Scaffold(
      appBar: const BBAppBar(),
      body: Center(
        child: Column(
          children: [
            SettingsList(
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
                                    (language) =>
                                    ListTile(
                                      title: Text(
                                        language['name'].toString(),
                                      ),
                                      onTap: () {
                                        settings.applicationLanguage =
                                            language['code'].toString();
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
                      initialValue: settings.isDarkModeEnabled,
                      leading: const Icon(Icons.nightlight),
                      title: Text(translations.set_darkmode),
                      onToggle: (value) {
                        settings.applicationTheme = value;
                      },
                    ),
                    SettingsTile.navigation(
                      leading: const Icon(Icons.edit_road),
                      title: Text(translations.set_distance_unit),
                      value: Text(settings.distanceUnit),
                      onPressed: (BuildContext context) {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: SUPPORTED_DISTANCE_UNITS
                                  .map(
                                    (unit) =>
                                    ListTile(
                                      title: Text(unit),
                                      onTap: () {
                                        settings.distanceUnit = unit;
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
            )
          ],
        ),
      ),);
  }
}
