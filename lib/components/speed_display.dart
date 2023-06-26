import 'package:auto_size_text/auto_size_text.dart';
import 'package:bike_buddy/extensions/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:rainbow_color/rainbow_color.dart';

Rainbow speedColor = Rainbow(
  spectrum: const [
    Color.fromARGB(255, 157, 252, 103),
    Color.fromARGB(255, 255, 253, 112),
    Color.fromARGB(255, 253, 75, 75),
  ],
  rangeStart: 5,
  rangeEnd: 30,
);

class SpeedDisplay extends StatelessWidget {
  final double value;
  final double? width;

  const SpeedDisplay({required this.value, this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
        side: BorderSide(
          width: 5,
          color: speedColor[value.clamp(5, 30)],
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: 90,
        padding: const EdgeInsets.all(14),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Column(
            children: [
              AutoSizeText(
                value.toPrecision(1).toString(),
                maxLines: 1,
                style: const TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
              const Text(
                "km/h",
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
