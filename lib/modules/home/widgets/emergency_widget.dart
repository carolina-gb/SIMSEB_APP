import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/modules/sos/page/sos.dart';
import 'package:fluttertest/shared/helpers/global_helper.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:provider/provider.dart';

class EmergencyWidget extends StatefulWidget {
  const EmergencyWidget({super.key});

  @override
  State<EmergencyWidget> createState() => _EmergencyWidgetState();
}

class _EmergencyWidgetState extends State<EmergencyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    final sosPageKey = GlobalHelper.genKey();
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    fp.addPage(
      key: sosPageKey,
      content: SosPage(globalKey: sosPageKey),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonSize = size.height * 0.18;

    return Center(
      child: GestureDetector(
        onTap: _onTap, // ya no hay long press
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Pulso animado
            ScaleTransition(
              scale: Tween(begin: 1.0, end: 1.2).animate(CurvedAnimation(
                parent: _controller,
                curve: Curves.easeOut,
              )),
              child: Container(
                width: buttonSize + 80,
                height: buttonSize + 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFF6A5E).withOpacity(0.2),
                ),
              ),
            ),
            Center(
              child: Container(
                width: buttonSize + 40,
                height: buttonSize + 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Color(0xFFEAEAEA), Color(0x00FFFFFF)],
                    radius: 0.85,
                    center: Alignment.center,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: buttonSize,
                    height: buttonSize,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFFFF6A5E), Color(0xFFFF936C)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.white,
                          blurRadius: 15,
                          spreadRadius: 5,
                          offset: Offset(-5, -5),
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                          blurRadius: 15,
                          spreadRadius: 5,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'SOS',
                            style: TextStyle(
                              fontSize: 30,
                              color: AppTheme.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Presiona para alertar',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
