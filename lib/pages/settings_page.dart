import 'package:flutter/material.dart';
import 'package:bike_buddy/components/bb_appbar.dart';
import 'package:bike_buddy/components/bb_drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BBAppBar(context),
      drawer: BBDrawer(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const <Widget>[
            Text(
              'Text for test',
            ),
          ],
        ),
      ),
    );
    ;
  }
}
