import 'package:flutter/material.dart';
import 'package:fluttertest/modules/Login/page/login_page.dart';
import 'package:fluttertest/modules/home/page/home.dart';
import 'package:fluttertest/modules/my_requests/page/my_request.dart';
import 'package:fluttertest/modules/new_request/page/New_request.dart';
import 'package:fluttertest/modules/not_found/pages/page_not_found.dart';
import 'package:fluttertest/modules/splash/page/splash_screen.dart';

class AppRoutes {
  static const initialRoute = '/splash';

  static Map<String, Widget Function(BuildContext)> routes = {
    '/splash': (_) => const SplashPage(),
    '/loginPage': (_) => const LoginPage(),
    '/home': (_) => const HomePage(),
    // '/newRequest': (_) => const NewRequestPage(),
    // '/myRequest': (_) => const MyRequestsPage()
  };
  
  static get keyPage => null;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const PageNotFound(),
    );
  }
}
