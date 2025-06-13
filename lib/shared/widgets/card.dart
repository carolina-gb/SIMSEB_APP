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
    final size = MediaQuery.of(context).size;
    return Card(
        clipBehavior: Clip.hardEdge,
        elevation: 10,
        shadowColor: AppTheme.gray1,
        color: AppTheme.white,
        margin: const EdgeInsets.only(bottom: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          title: Row(
            children: [
              const TitleWidget(
                title: 'Solicitud: ',
                fontWeight: FontWeight.bold,
                color: AppTheme.black,
              ),
              TitleWidget(
                title: widget.numberRequest,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(vertical:  size.height * 0.01),
                child: TextWidget(
                  title: 'Descipción: ${widget.detail}',
                  color: AppTheme.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              TextWidget(
                title: 'Tipo: ${widget.type}',
                color: AppTheme.black,
                fontWeight: FontWeight.normal,
              ),
              Padding(
                padding: EdgeInsets.only(top:  size.height * 0.02),
                child: Row(
                  mainAxisAlignment:  MainAxisAlignment.spaceAround,
                  children: [
                    const TextWidget(title: 'Estado'),
                    TextWidget(title: widget.status)
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
