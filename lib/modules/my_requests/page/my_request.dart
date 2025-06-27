import 'package:flutter/material.dart';
import 'package:fluttertest/modules/my_requests/widgets/my_requests_widget.dart';
import 'package:fluttertest/shared/widgets/provider_layout.dart';

class MyRequestsPage extends StatefulWidget {
  const MyRequestsPage({super.key, required this.globalKey});

  final GlobalKey globalKey;
  @override
  State<MyRequestsPage> createState() => _MyRequestsPageState();
}

class _MyRequestsPageState extends State<MyRequestsPage> {
  @override
  Widget build(BuildContext context) {
    return  MainLayout(
        key: widget.globalKey,
        keyDismiss: widget.globalKey,
        backPageView: true,
        requiredStack: false,
        nameInterceptor: 'my_request',
        icon: Icons.feed_outlined,
        title: "Mis solicitudes",
        isHomePage: false,
        showBottomNavBar: true,
        child: MyRequestsWidget( globalKey: widget.globalKey,),
        );
  }
}