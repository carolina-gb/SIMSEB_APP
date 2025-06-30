import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:fluttertest/shared/widgets/filled_button.dart';
import 'package:fluttertest/shared/widgets/text.dart';
import 'package:fluttertest/shared/widgets/title.dart';
import 'package:provider/provider.dart';

class SosWidget extends StatefulWidget {
  const SosWidget({super.key});

  @override
  State<SosWidget> createState() => _SosWidgetState();
}

class _SosWidgetState extends State<SosWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
      final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.2, bottom: size.height * 0.08),
          child: Image.asset(AppTheme.sosPath),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.02,
            horizontal: size.width * 0.17,
          ),
          child: const TitleWidget(
            title: "Comunicandose con las autoridades",
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppTheme.white,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.02,
            horizontal: size.width * 0.17,
          ),
          child: const TextWidget(
            title:
                "Mantén la calma. La policía ya está en camino. Por favor, permanece tranquilo(a) y seguro(a) hasta que lleguen.",
            color: AppTheme.white,
            fontWeight: FontWeight.normal,
            fontSize: 18,
            textAlign: TextAlign.start,
          ),
        ),
        FilledButtonWidget(
          text: "Cancelar solicitud",
          color: AppTheme.gray3,
          width: size.width * 0.02,
          onPressed: () {
            fp.clearAllPages();
          },
        )
      ],
    );
  }
}
