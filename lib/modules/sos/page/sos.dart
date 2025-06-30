import 'package:flutter/material.dart';
import 'package:fluttertest/modules/sos/widget/sos_widget.dart';
import 'package:fluttertest/shared/widgets/provider_layout.dart';

class SosPage extends StatefulWidget {
  const SosPage({super.key, required this.globalKey});
  final GlobalKey globalKey;
  @override
  State<SosPage> createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
        requiredStack: false,
        keyDismiss: widget.globalKey,
        key: widget.globalKey,
        isHomePage: true,
        backPageView: false,
        nameInterceptor: 'sos',
        isSosPage: true,
        child: const SosWidget());
  }
}
