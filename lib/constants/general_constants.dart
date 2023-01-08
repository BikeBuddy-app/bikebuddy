// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const List<String> SUPPORTED_DISTANCE_UNITS = ["kilometer", "mile"];

ButtonStyle kSmallRoundButtonStyle = ElevatedButton.styleFrom(
    minimumSize: Size(40, 40),
    shape: CircleBorder(),);

ButtonStyle kMediumRoundButtonStyle = ElevatedButton.styleFrom(
    minimumSize: Size(82, 82),
    shape: CircleBorder(),);

ButtonStyle kLargeRoundButtonStyle = ElevatedButton.styleFrom(
  minimumSize: Size(100, 100),
  shape: CircleBorder(),
);
