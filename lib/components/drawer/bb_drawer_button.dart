import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton(this.text, this.navigateTo, {super.key});

  final String text;
  final String navigateTo;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => {Navigator.pushNamed(context, navigateTo)},
      child: ListTile(
        title: Center(
          child: Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: text[0],
                    style: const TextStyle(color: Colors.red)),
                TextSpan(text: text.substring(1))
              ],
            ),
          ),
        ),
      ),);
  }
}
