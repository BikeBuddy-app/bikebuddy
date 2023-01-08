import 'package:flutter/material.dart';

class BBAppBar extends AppBar {
  BBAppBar({super.key})
      : super(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    IconData(0xe1d2, fontFamily: 'MaterialIcons'),
                  )),
              RichText(
                  text: const TextSpan(
                      style: TextStyle(fontSize: 25),
                      children: <TextSpan>[
                    TextSpan(text: "B", style: TextStyle(color: Colors.red)),
                    TextSpan(text: "ike", style: TextStyle()),
                    TextSpan(text: "B", style: TextStyle(color: Colors.red)),
                    TextSpan(text: "uddy")
                  ]))
            ]));

  BBAppBar.hideBackArrow({super.key})
      : super(
            automaticallyImplyLeading: false,
            title: Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                Widget>[
              const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    IconData(0xe1d2, fontFamily: 'MaterialIcons'),
                  )),
              RichText(
                  text: const TextSpan(
                      style: TextStyle(fontSize: 25),
                      children: <TextSpan>[
                    TextSpan(text: "B", style: TextStyle(color: Colors.red)),
                    TextSpan(text: "ike", style: TextStyle()),
                    TextSpan(text: "B", style: TextStyle(color: Colors.red)),
                    TextSpan(text: "uddy")
                  ]))
            ]));
}
