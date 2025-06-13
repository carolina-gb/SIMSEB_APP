import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/shared/widgets/text.dart';
import 'package:fluttertest/shared/widgets/title.dart';

class EmergencyInformationWidget extends StatefulWidget {
  const EmergencyInformationWidget({super.key});

  @override
  State<EmergencyInformationWidget> createState() =>
      _EmergencyInformationWidgetState();
}

class _EmergencyInformationWidgetState
    extends State<EmergencyInformationWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: size.height * 0.2,
            width: size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TitleWidget(
                  title: "¿Estas en una emergencia?",
                  fontSize: size.width * 0.06,
                  fontWeight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                    title:
                        "Presiona el botón de abajo y la ayuda te llegará pronto.",
                    fontSize: size.width * 0.04,
                    color: AppTheme.black,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          Image.asset(AppTheme.ImageInformationWidget)
        ],
      ),
    );
  }
}
