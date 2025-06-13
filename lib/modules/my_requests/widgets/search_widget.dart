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
        decoration: const BoxDecoration(
            color: AppTheme.gray1,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              prefixIcon: IconButton(
                icon: const Icon(
                  Icons.search,
                  size: 35,
                ),
                onPressed: () {
                  print('hola');
                },
              ),
              enabledBorder: InputBorder.none,
              hintText: 'Buscar...'),
        ),
      ),
    );
  }
}
