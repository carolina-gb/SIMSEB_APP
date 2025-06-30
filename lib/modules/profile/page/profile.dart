import 'package:flutter/material.dart';
import 'package:fluttertest/modules/profile/widget/profile_form.dart';
import 'package:fluttertest/shared/widgets/provider_layout.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.globalKey});
  final GlobalKey globalKey;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
        requiredStack: false,
        keyDismiss: widget.globalKey,
        key: widget.globalKey,
        isHomePage: false,
        backPageView: true,
        nameInterceptor: 'profile',
        title: 'Mi perfil',
        child: const ProfileFormWidget());
  }
}
