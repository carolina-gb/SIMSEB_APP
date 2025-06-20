import 'package:flutter/material.dart';
import 'package:fluttertest/modules/Login/widgets/form_login.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:fluttertest/shared/widgets/main_layout.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late FunctionalProvider fp;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fp = Provider.of<FunctionalProvider>(context, listen: false);
      fp.clearAllPages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      nameInterceptor: 'login',
      title: 'Inicie Sesión para continuar',
      backPageView: false ,
      requiredStack: false ,
      isLoginPage: true,
      isScrolleabe: false,
      showBottomNavBar: false,
      child: FormLoginPage());
  }
}