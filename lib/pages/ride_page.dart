import 'package:bike_buddy/components/bike_buddy_bar.dart';
import 'package:flutter/material.dart';

class RidePage extends StatefulWidget {
  const RidePage({super.key});

  static const String routeName = '/ride';

  @override
  State<RidePage> createState() => _RidePageState();
}

class _RidePageState extends State<RidePage> {
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
              flex: 3,
              child: Container(
                color: Colors.green,
                child: const Center(
                  child: Text("69km/h"),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text("21:37"),
                    Text("420km"),
                    Text("42.0"),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 15,
              child: Image.asset("images/map.png"),
            ),
            const Expanded(
              flex: 2,
              child: Icon(
                IconData(0xe47c, fontFamily: 'MaterialIcons'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
