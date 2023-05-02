import 'package:flutter/material.dart';

class BBAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BBAppBar({
    this.automaticallyImplyLeading = true,
    super.key,
  });

  const BBAppBar.hideBackArrow({
    this.automaticallyImplyLeading = false,
    super.key,
  });

  final bool automaticallyImplyLeading;

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight); // default is 56.0

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.directions_bike),
          ),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineMedium,
              children: const <TextSpan>[
                TextSpan(text: "B", style: TextStyle(color: Colors.red)),
                TextSpan(text: "ike"),
                TextSpan(text: "B", style: TextStyle(color: Colors.red)),
                TextSpan(text: "uddy")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
