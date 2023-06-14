import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Countdown extends StatelessWidget {
  const Countdown({
    super.key,
    required this.controller,
  });

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            translations.ready_text,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
          ),
          const Divider(
            height: 10,
            thickness: 0,
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      value: controller.value,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    (controller.value * controller.duration!.inSeconds).ceil().toString(),
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
