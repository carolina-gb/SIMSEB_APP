import 'package:flutter/material.dart';
import 'package:fluttertest/modules/Login/page/login_page.dart';
import 'package:fluttertest/modules/not_found/pages/page_not_found.dart';
import 'package:fluttertest/modules/splash/page/splash_screen.dart';

class AppRoutes {
  static const initialRoute = '/splash';

  static Map<String, Widget Function(BuildContext)> routes = {
    '/splash': (_) => const SplashPage(),
    // '/loginPage': (_) => const LoginPage(),
    // '/home': (_) => const HomePage(),
  };
  
  static get keyPage => null;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const PageNotFound(),
    );
  }
}
