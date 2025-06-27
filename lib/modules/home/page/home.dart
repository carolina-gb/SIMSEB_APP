import 'package:flutter/material.dart';
import 'package:fluttertest/modules/home/widgets/home_widget.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:fluttertest/shared/widgets/provider_layout.dart';
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
      // fp.clearAllPages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
        requiredStack: true,
        nameInterceptor: 'home',
        icon: Icons.abc,
        isHomePage: true,
        // isScrolleabe: true,
        showBottomNavBar: true,
        child: HomeWidget(),
        );
  }
}
