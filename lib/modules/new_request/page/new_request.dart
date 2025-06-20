import 'package:flutter/material.dart';
import 'package:fluttertest/modules/new_request/widgets/new_request_form.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:fluttertest/shared/widgets/layout.dart';
import 'package:provider/provider.dart';

class NewRequestPage extends StatefulWidget {
  const NewRequestPage({super.key, required this.globalKey});
  final GlobalKey globalKey;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      key: widget.globalKey,
      backPageView: true,
      nameInterceptor: 'NewRequestPage',
      isScrolleabe: false,
      showBottomNavBar: true,
      child: NewRequestFormWidget(globalKey: widget.globalKey,),
    );
  }
}
