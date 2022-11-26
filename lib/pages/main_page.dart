import 'package:bike_buddy/components/bike_buddy_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.red,
                child: Center(child: Text("Searchbar")),
              ),
            ),
            Expanded(
              flex: 12,
              child: Image.asset("images/map.png"),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () => {
                  Navigator.pushNamed(context, '/ride'),
                },
                child: Column(children: [
                  Icon(
                    IconData(0xe1d2, fontFamily: 'MaterialIcons'),
                  ),
                  Text("jedz"),
                ]),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(onPressed: () {}, child: Text("trasa")),
                    TextButton(onPressed: () {}, child: Text("historia")),
                    TextButton(onPressed: () {}, child: Text("osiagniecia")),
                    TextButton(
                        onPressed: () => {
                              Navigator.pushNamed(context, '/settings'),
                            },
                        child: Text("ustawienia"))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
