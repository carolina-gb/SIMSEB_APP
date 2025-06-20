import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/modules/my_requests/widgets/search_widget.dart';
import 'package:fluttertest/shared/helpers/global_helper.dart';
import 'package:fluttertest/shared/widgets/card.dart';
import 'package:fluttertest/shared/widgets/filled_button.dart';
import 'package:fluttertest/shared/widgets/title.dart';

class MyRequestsWidget extends StatefulWidget {
  const MyRequestsWidget({
    super.key,
  });

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
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.feed_outlined, size: 35),
              SizedBox(
                width: size.width * 0.04,
              ),
              const TitleWidget(
                title: 'Mis solicitudes',
                fontSize: 35,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
            child: const SearchWidget(),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size.height * 0.05),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.hardEdge,
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: CardWidget(
                        numberRequest: request['numberRequest'],
                        detail: request['detail'],
                        type: request['type'],
                        status: request['status']),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
