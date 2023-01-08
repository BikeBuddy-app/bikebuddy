import 'package:flutter/material.dart';
import 'package:bike_buddy/components/bb_appbar.dart';

class PausePage extends StatefulWidget {
  const PausePage({super.key});

  static const String routeName = '/pause';

  @override
  State<PausePage> createState() => _PausePageState();
}

class _PausePageState extends State<PausePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BBAppBar(),
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
  }
}
