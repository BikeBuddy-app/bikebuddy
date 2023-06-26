import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ValueDisplay extends StatelessWidget {
  final String value;
  final double? width;

  const ValueDisplay({required this.value, this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          width: 5,
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.primary,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: 55,
        padding: const EdgeInsets.all(14),
        child: FittedBox(
          fit: BoxFit.fill,
          child: AutoSizeText(
            value,
            maxLines: 1,
            style: const TextStyle(
              fontFamily: 'RobotoSlab',
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
