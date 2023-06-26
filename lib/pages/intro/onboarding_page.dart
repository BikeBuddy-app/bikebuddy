import 'package:bike_buddy/constants/default_values.dart' as default_values;
import 'package:bike_buddy/constants/general_constants.dart' as constants;
import 'package:bike_buddy/pages/main_page.dart';
import 'package:bike_buddy/utils/settings_manager.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const String routeName = '/onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  String _userName = '';
  int _userWeight = default_values.riderWeight;

  void handleOnboardingComplete() {
    final settings = context.read<SettingsManager>();
    settings.riderWeight = _userWeight;
    settings.username = _userName;
    settings.onboardingCompleted = true;
  }

  PageViewModel _buildLastPage(translations) {
    String pageTitle = translations.ob_onboarding_finished_title.replaceFirst('<username>', _userName);
    Widget pageBody = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 350), // Adjust the value as needed
          child: Text(translations.ob_onboarding_finished_text),
        ),
      ],
    );
    PageDecoration pageDecoration = const PageDecoration(
      bodyAlignment: Alignment.center,
      fullScreen: true,
    );
    Widget pageFooter = ElevatedButton(
      onPressed: () {
        handleOnboardingComplete();
        Navigator.pushNamed(context, MainPage.routeName);
      },
      child: Text(translations.ob_onboarding_finished_button)
    );

    if (_userName == '') {
      pageTitle = translations.ob_no_username_title;
      pageBody = Text(translations.ob_no_username_text);
      pageFooter = Container(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _introKey.currentState?.animateScroll(1);
            });
          },
          child: Text(translations.ob_no_username_button),
        ),
      );
    }

    return PageViewModel(
      title: pageTitle,
      bodyWidget: pageBody,
      decoration: pageDecoration,
      footer: pageFooter,
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsManager>();
    final translations = AppLocalizations.of(context)!;
    return IntroductionScreen(
        key: _introKey,
        pages: [
          PageViewModel(
            title: translations.ob_welcome,
            body: translations.ob_intro_text,
            image: const Center(child: Icon(Icons.directions_bike)),
            decoration: const PageDecoration(
              pageColor: Colors.blue,
            ),
          ),
          PageViewModel(
            title: translations.ob_name_input_title,
            bodyWidget: TextField(
              textAlign: TextAlign.center,
              onChanged: (text) {
                setState(() {
                  _userName = text;
                });
              },
            ),
            image: const Center(child: Icon(Icons.person_pin_rounded)),
          ),
          PageViewModel(
            title: translations.ob_weight_input_title,
            decoration: const PageDecoration(
              bodyAlignment: Alignment.center,
            ),
            bodyWidget: NumberPicker(
              value: _userWeight,
              minValue: constants.MIN_RIDER_WEIGHT,
              maxValue: constants.MAX_RIDER_WEIGHT,
              axis: Axis.horizontal,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border:
                    Border.all(color: Theme.of(context).colorScheme.secondary),
              ),
              textMapper: (value) => '$value ${settings.weightUnit}',
              onChanged: (value) => setState(() => _userWeight = value),
            ),
          ),
          _buildLastPage(translations),
        ],
        showDoneButton: false,
        next: const Icon(
          Icons.arrow_forward,
          color: Colors.blueAccent,
        ),
        onDone: () {});
  }
}
