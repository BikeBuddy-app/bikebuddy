import 'package:flutter/material.dart';

import '../constants/general_constants.dart';

class CustomRoundButton extends StatelessWidget {
  CustomRoundButton.large(
      {required this.onPressed, required this.icon, Color? backgroundColor}) {
    buttonStyle = backgroundColor != null
        ? kLargeRoundButtonStyle.copyWith(
        backgroundColor: MaterialStatePropertyAll(backgroundColor))
        : kLargeRoundButtonStyle;
  }

  CustomRoundButton.medium(
      {required this.onPressed,
        required this.icon,
        Color? backgroundColor,
        void Function()? onLongPress}) {
    if (onLongPress != null) this.onLongPress = onLongPress;
    buttonStyle = backgroundColor != null
        ? kMediumRoundButtonStyle.copyWith(
        backgroundColor: MaterialStatePropertyAll(backgroundColor))
        : kMediumRoundButtonStyle;
  }

  CustomRoundButton.small(
      {required this.onPressed, required this.icon, Color? backgroundColor}) {
    buttonStyle = backgroundColor != null
        ? kSmallRoundButtonStyle.copyWith(
        backgroundColor: MaterialStatePropertyAll(backgroundColor))
        : kSmallRoundButtonStyle;
  }

  final void Function() onPressed;
  void Function() onLongPress = () {};
  final Icon icon;
  ButtonStyle buttonStyle = kMediumRoundButtonStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: buttonStyle,
      onPressed: onPressed,
      child: icon,
    );
  }
}
