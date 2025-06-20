import 'package:flutter/material.dart';
import 'package:fluttertest/modules/my_requests/widgets/my_requests_widget.dart';
import 'package:fluttertest/shared/widgets/layout.dart';

class MyRequestsPage extends StatefulWidget {
  const MyRequestsPage({super.key, required this.globalKey});

  final GlobalKey globalKey;
  @override
  State<MyRequestsPage> createState() => _MyRequestsPageState();
}

class _MyRequestsPageState extends State<MyRequestsPage> {
  @override
  Widget build(BuildContext context) {
    return  Layout(
        key: widget.globalKey,
        backPageView: true,
        nameInterceptor: 'my_request',
        title: "Mis solicitudes",
        isHomePage: false,
        isScrolleabe: false,
        showBottomNavBar: true,
        child: MyRequestsWidget(),
        );
  }
}