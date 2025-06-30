import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/modules/sos/page/sos.dart';
import 'package:fluttertest/shared/helpers/global_helper.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:fluttertest/shared/widgets/alert_template.dart';
import 'package:provider/provider.dart';

class EmergencyWidget extends StatefulWidget {
  const EmergencyWidget({super.key});

  @override
  State<EmergencyWidget> createState() => _EmergencyWidgetState();
}

class _EmergencyWidgetState extends State<EmergencyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer _timer;
  bool _isHolding = false;
  int _holdDuration = 3;
  int _secondsHeld = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); // animación continua
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startHoldTimer() {
    _secondsHeld = 0;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _secondsHeld++;
      if (_secondsHeld >= _holdDuration) {
        _onHoldComplete();
        timer.cancel();
      }
    });
  }

  void _cancelHoldTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  void _onHoldComplete() {
    // Acción cuando se mantiene presionado 3 segundos
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
        onLongPressStart: (_) {
          setState(() {
            _isHolding = true;
          });
          _controller.stop();
          _startHoldTimer();
        },
        onLongPressEnd: (_) {
          setState(() {
            _isHolding = false;
          });
          _controller.repeat(reverse: true);
          _cancelHoldTimer();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animación de pulso
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
                    colors: [
                      Color(0xFFEAEAEA),
                      Color(0x00FFFFFF),
                    ],
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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: _isHolding
                          ? const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 177, 171, 171),
                                Color(0xFFCA5B47)
                              ], // tono más oscuro
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                          : const LinearGradient(
                              colors: [Color(0xFFFF6A5E), Color(0xFFFF936C)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                      boxShadow: [
                        const BoxShadow(
                          color: AppTheme.white,
                          blurRadius: 15,
                          spreadRadius: 5,
                          offset: Offset(-5, -5),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          spreadRadius: 5,
                          offset: const Offset(5, 5),
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
                            'Presiona 3 segundos',
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
