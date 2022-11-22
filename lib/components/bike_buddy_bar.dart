import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  final Text title;
  CustomAppBar({required this.title})
      : super(
          title: title,
        );
}
