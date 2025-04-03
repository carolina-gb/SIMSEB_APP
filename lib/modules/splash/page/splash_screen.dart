import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/modules/Login/page/login_page.dart';
import 'package:fluttertest/shared/helpers/global_helper.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late FunctionalProvider fp;

  @override
  void initState() {
    fp = Provider.of<FunctionalProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _verifySessions();
    });
    Timer(const Duration(milliseconds: 2000), () {
      _verifySession();
    });
    super.initState();
  }

  void _verifySession() async {
    Navigator.pushAndRemoveUntil(
        context,
        GlobalHelper.navigationFadeIn(context, const LoginPage()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.gray2,
        resizeToAvoidBottomInset: false,
        body: Container(
          height: size.height,
          width: size.width,
          alignment: FractionalOffset.center,
          decoration: const BoxDecoration(
            color: AppTheme.transparent,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(AppTheme.logoIcon,width: size.width * 0.5,)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
