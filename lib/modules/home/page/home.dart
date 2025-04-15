import 'package:flutter/material.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:fluttertest/shared/widgets/main_layout.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        backPageView: true,
        requiredStack: false,
        nameInterceptor: 'home',
        isHomePage: true,
        child: Text('data'));
  }
}
