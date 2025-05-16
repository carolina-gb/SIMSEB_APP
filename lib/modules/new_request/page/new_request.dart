import 'package:flutter/material.dart';
import 'package:fluttertest/modules/new_request/new_request_form.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:fluttertest/shared/widgets/main_layout.dart';
import 'package:provider/provider.dart';

class NewRequestPage extends StatefulWidget {
  const NewRequestPage({super.key});

  @override
  State<NewRequestPage> createState() => _NewRequestPageState();
}

class _NewRequestPageState extends State<NewRequestPage> {
  
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
        isScrolleabe: true,
        child: NewRequestFormWidget(),
        );
  }
}
