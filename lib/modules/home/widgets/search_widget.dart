import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
            color: AppTheme.white,
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: TextFormField(
          decoration: InputDecoration(
              prefixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  print('hola');
                },
              ),
              enabledBorder: InputBorder.none),
        ),
      ),
    );
  }
}
