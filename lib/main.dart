import 'package:flutter/material.dart';

import 'pages/main_page.dart';

void main() {
  runApp(const BikeBuddy());
}

class BikeBuddy extends StatelessWidget {
  const BikeBuddy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BikeBuddy',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
      },
    );
  }
}
