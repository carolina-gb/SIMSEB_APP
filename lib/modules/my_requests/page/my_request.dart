import 'package:flutter/material.dart';
import 'package:fluttertest/modules/my_requests/widgets/my_requests_widget.dart';
import 'package:fluttertest/shared/widgets/main_layout.dart';

class MyRequestsPage extends StatefulWidget {
  const MyRequestsPage({super.key});

  @override
  State<MyRequestsPage> createState() => _MyRequestsPageState();
}

class _MyRequestsPageState extends State<MyRequestsPage> {
  @override
  Widget build(BuildContext context) {
    return const MainLayout(
        backPageView: true,
        requiredStack: false,
        nameInterceptor: 'my_request',
        isHomePage: false,
        isScrolleabe: false,
        showBottomNavBar: true,
        child: MyRequestsWidget(),
        );
  }
}