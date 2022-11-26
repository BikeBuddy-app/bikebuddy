import 'package:bike_buddy/components/bike_buddy_bar.dart';
import 'package:flutter/material.dart';

class PausePage extends StatefulWidget {
  const PausePage({super.key});

  @override
  State<PausePage> createState() => _PausePageState();
}

class _PausePageState extends State<PausePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Text for test',
            ),
          ],
        ),
      ),
    );
  }
}
