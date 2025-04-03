import 'package:flutter/material.dart';
import 'package:fluttertest/env/enviroment.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:fluttertest/shared/providers/navegation_verify_provider.dart';
import 'package:fluttertest/shared/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  String environment = const String.fromEnvironment('ENVIRONMENT',
      defaultValue: Environment.dev);
  Environment().initConfig(environment);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appName = Environment().config!.appName;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FunctionalProvider()),
        ChangeNotifierProvider(create: (_) => NavegationVerifyProvider())
      ],
      child: MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme().theme(),
        initialRoute: AppRoutes.initialRoute,
        navigatorObservers: [HeroController()],
        routes: AppRoutes.routes,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        // locale: const Locale('es'),
        // supportedLocales: const [
        //   Locale('es'),
        // ],
      ),
    );
  }
}
