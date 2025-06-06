import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';

class EmergencyWidget extends StatelessWidget {
  const EmergencyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonSize = size.height * 0.18;

    return Center(
      child: Container(
        height: size.height * 0.25,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6FB),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Container(
            width: buttonSize + 40,
            height: buttonSize + 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Color(0xFFEAEAEA),
                  Color(0x00FFFFFF), // centro brillante, exterior difuso
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
                  gradient: const LinearGradient(
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
      ),
    );
  }
}
