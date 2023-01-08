import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({super.key})
      : super(
          title: const Center(child: Text("BikeBuddy")),
        );

  CustomAppBar.hideBackArrow({super.key})
      : super(
          title: const Center(child: Text("BikeBuddy")),
          automaticallyImplyLeading: false,
        );
}
