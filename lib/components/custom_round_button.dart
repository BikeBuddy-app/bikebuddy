import 'package:flutter/material.dart';

import 'package:bike_buddy/constants/general_constants.dart';

class CustomRoundButton extends StatelessWidget {
  CustomRoundButton.large({
    required this.onPressed,
    required this.icon,
    this.backgroundColor,
    this.onLongPress,
    super.key,
  }) {
    buttonStyle = kLargeRoundButtonStyle;
  }

  CustomRoundButton.medium({
    required this.onPressed,
    required this.icon,
    this.backgroundColor,
    this.onLongPress,
    super.key,
  }) {
    buttonStyle = kMediumRoundButtonStyle;
  }

  CustomRoundButton.small({
    required this.onPressed,
    required this.icon,
    this.backgroundColor,
    this.onLongPress,
    super.key,
  }) {
    buttonStyle = kSmallRoundButtonStyle;
  }

  final void Function()? onLongPress;
  late final ButtonStyle buttonStyle;
  final Icon icon;
  final Color? backgroundColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: buttonStyle.copyWith(
        backgroundColor: MaterialStatePropertyAll(backgroundColor),
      ),
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: icon,
    );
  }
}
