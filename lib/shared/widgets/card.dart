import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/shared/widgets/text.dart';
import 'package:fluttertest/shared/widgets/title.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({
    super.key,
    required this.numberRequest,
    required this.detail,
    required this.type,
    required this.status,
  });
  final String numberRequest;
  final String detail;
  final String type;
  final String status;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.hardEdge,
        color: Colors.green[100],
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          title: Row(
            children: [
              const TitleWidget(
                title: 'Solicitud: ',
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryDarkest,
              ),
              TitleWidget(title: widget.numberRequest),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(title: 'Descripcion:           '),
                  Expanded(child: TextWidget(title: widget.detail))
                ],
              ),
              Row(
                children: [
                  const TextWidget(title: 'Tipo:                        '),
                  TextWidget(title: widget.type)
                ],
              ),
              Row(
                children: [
                  const TextWidget(title: 'Estado:                    '),
                  TextWidget(title: widget.status)
                ],
              ),
            ],
          ),
        ));
  }
}
