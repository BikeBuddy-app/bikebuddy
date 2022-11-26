import 'package:bike_buddy/components/bike_buddy_bar.dart';
import 'package:flutter/material.dart';

class RidePage extends StatefulWidget {
  const RidePage({super.key});

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
                child: Center(
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
                  children: [
                    Container(
                      child: Text("21:37"),
                    ),
                    Container(
                      child: Text("420km"),
                    ),
                    Container(
                      child: Text("42.0"),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 15,
              child: Image.asset("images/map.png"),
            ),
            Expanded(
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
