import 'package:flutter/material.dart';
import 'package:fluttertest/shared/widgets/card.dart';

class MyRequestsWidget extends StatefulWidget {
  const MyRequestsWidget({super.key, required this.size});
  final Size size;

  @override
  State<MyRequestsWidget> createState() => _MyRequestsWidgetState();
}

class _MyRequestsWidgetState extends State<MyRequestsWidget> {
  final List<Map<String, dynamic>> requests = List.generate(
    5,
    (index) => {
      'numberRequest': 'Project name',
      'detail':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'type': 'Desaseo',
      'status': 'Approved'
    },
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.size.height * 0.02),
      child: SizedBox(
        height: widget.size.height * 0.55,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              return CardWidget(
                  numberRequest: request['numberRequest'],
                  detail: request['detail'],
                  type: request['type'],
                  status: request['status']);
            }),
      ),
    );
  }
}
