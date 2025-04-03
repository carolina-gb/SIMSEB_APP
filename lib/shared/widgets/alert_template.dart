import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/shared/widgets/filled_button.dart';
import 'package:fluttertest/shared/widgets/outlined_button.dart';
import 'package:fluttertest/shared/widgets/text.dart';
import 'package:fluttertest/shared/widgets/text_button.dart';
import 'package:provider/provider.dart';
import '../providers/functional_provider.dart';

Text titleAlerts({required String title, required Color color}) {
  return Text(
    title,
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: color,
    ),
  );
}

Padding messageAlerts(Size size,
    {required String message, Color? color, FontWeight? fontWeight}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
    child: Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? Colors.black,
      ),
    ),
  );
}

class AlertLoading extends StatefulWidget {
  const AlertLoading({super.key});

  @override
  State<AlertLoading> createState() => _AlertLoadingState();
}

class _AlertLoadingState extends State<AlertLoading>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      lowerBound: 0.5,
      // animationBehavior : AnimationBehavior.preserve,
      reverseDuration: const Duration(milliseconds: 500),
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: 30,
        width: 40,
        child: FadeTransition(
          opacity: _animation,
          child: const Stack(
            alignment: Alignment.topCenter,
            children: [
              Text('Logo')
              // SvgPicture.asset(
              //   AppTheme.logoIcon,
              //   fit: BoxFit.fill,
              //   colorFilter: const ColorFilter.mode(
              //       AppTheme.primaryMedium, BlendMode.srcIn),
              //   width: responsive.dp(18),
              //   height: responsive.dp(18),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class SvgPicture {}

class AlertGeneric extends StatefulWidget {
  final bool dismissable;
  final GlobalKey? keyToClose;
  final Widget content;
  final bool? heightOption;

  const AlertGeneric({
    super.key,
    required this.content,
    this.heightOption = false,
    this.dismissable = false,
    this.keyToClose,
  });

  @override
  State<AlertGeneric> createState() => _AlertGenericState();
}

class _AlertGenericState extends State<AlertGeneric> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
            height: widget.heightOption == true ? size.height * 0.54 : null,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: AppTheme.white),
            child: Material(
                type: MaterialType.transparency, child: widget.content)),
        if (widget.dismissable)
          Positioned(
            top: -3,
            right: 0,
            child: SizedBox(
                height: 50,
                width: 50,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    final fp =
                        Provider.of<FunctionalProvider>(context, listen: false);
                    fp.dismissAlert(key: widget.keyToClose!);
                  },
                )),
          ),
      ],
    );
  }
}

class AlertTemplate extends StatefulWidget {
  final Widget content;
  final GlobalKey keyToClose;
  final bool? dismissAlert;
  final bool? animation;
  final double? padding;

  const AlertTemplate(
      {super.key,
      required this.content,
      required this.keyToClose,
      this.dismissAlert = false,
      this.animation = true,
      this.padding = 20});

  @override
  State<AlertTemplate> createState() => _AlertTemplateState();
}

class _AlertTemplateState extends State<AlertTemplate> {
  late GlobalKey keySummoner;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomOut(
        animate: false,
        duration: const Duration(milliseconds: 200),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(148, 0, 0, 0),
          body: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  final fp =
                      Provider.of<FunctionalProvider>(context, listen: false);
                  widget.dismissAlert == true
                      ? fp.dismissAlert(key: widget.keyToClose)
                      : null;
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                ),
              ),
              Container(
                padding: EdgeInsets.all(widget.padding ?? 20),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.animation == true
                            ? FadeInUpBig(
                                animate: true,
                                controller: (controller) {},
                                duration: const Duration(milliseconds: 300),
                                child: widget.content)
                            : widget.content,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class ErrorGeneric extends StatelessWidget {
  final GlobalKey keyToClose;
  final String message;
  final String? messageButton;
  final void Function()? onPress;
  final bool closeSession;

  const ErrorGeneric({
    super.key,
    required this.message,
    required this.keyToClose,
    this.messageButton,
    this.closeSession = false,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                color: AppTheme.error2),
            height: size.height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  child: const Icon(
                    Icons.close,
                    color: AppTheme.white,
                  ),
                ),
                const TextWidget(
                  title: 'Mensaje de error',
                  color: AppTheme.white,
                )
              ],
            )),
        SizedBox(height: size.height * 0.03),
        messageAlerts(size, message: message),
        SizedBox(height: size.height * 0.03),
        FilledButtonWidget(
          borderRadius: 5,
          width: size.width * 0.6,
          color: closeSession == false ? AppTheme.error2 : AppTheme.primaryDark,
          textButtonColor:
              closeSession == false ? AppTheme.white : AppTheme.primaryDarkest,
          text: messageButton ?? 'Aceptar',
          onPressed: (onPress != null)
              ? onPress
              : () async {
                  final fp =
                      Provider.of<FunctionalProvider>(context, listen: false);
                  fp.dismissAlert(key: keyToClose);
                },
        ),
        SizedBox(height: size.height * 0.02),
      ],
    );
  }
}

class SuccessInformation extends StatelessWidget {
  final GlobalKey keyToClose;
  final void Function()? onPressed;
  final String? message;
  final bool? isTitle;

  const SuccessInformation(
      {super.key,
      this.isTitle = true,
      required this.keyToClose,
      this.onPressed,
      this.message = 'body'});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                color: AppTheme.positiveMedium),
            height: size.height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  child: const Icon(
                    Icons.check,
                    color: AppTheme.white,
                  ),
                ),
                const TextWidget(
                  title: 'Mensaje de éxito',
                  color: AppTheme.white,
                )
              ],
            )),
        SizedBox(height: size.height * 0.015),
        // SvgPicture.asset(AppTheme.),
        const SizedBox(height: 25),
        messageAlerts(size, message: message!),
        SizedBox(height: size.height * 0.025),
        FilledButtonWidget(
          borderRadius: 5,
          width: size.width * 0.6,
          color: AppTheme.positiveMedium,
          textButtonColor: AppTheme.white,
          text: 'Aceptar',
          onPressed: onPressed,
        ),
        SizedBox(height: size.height * 0.02),
      ],
    );
  }
}

class ConfirmContent extends StatelessWidget {
  final String message;
  final void Function() confirm;
  final void Function()? cancel;

  const ConfirmContent({
    super.key,
    required this.message,
    required this.confirm,
    this.cancel,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                color: AppTheme.primaryDarkest),
            height: size.height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  child: const Icon(
                    Icons.info,
                    color: AppTheme.white,
                  ),
                ),
                const TextWidget(
                  title: 'Mensaje informativo',
                  color: AppTheme.white,
                )
              ],
            )),
        const SizedBox(height:  15),
        messageAlerts(size, message: message),
        const SizedBox(height:  25),
        SizedBox(width: size.width * 0.08),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (cancel != null) ...{
              TextButtonWidget(onPressed: cancel, nameButton: 'Cancelar'),
              SizedBox(width: size.width * 0.08),
            },
            FilledButtonWidget(
                color: AppTheme.primaryDarkest,
                onPressed: confirm,
                width: size.width * 0.05,
                height:  42,
                textButtonColor: AppTheme.white,
                borderRadius: 5,
                text: 'Aceptar'),
          ],
        ),
        SizedBox(height: size.height * 0.02),
      ],
    );
  }
}

class WarningAlert extends StatelessWidget {
  final GlobalKey keyToClose;
  final void Function()? confirm;
  final void Function()? cancel;
  final String? message;
  final String title;
  final bool? isTitle;

  const WarningAlert(
      {super.key,
      this.isTitle = true,
      required this.keyToClose,
      this.message = 'body',
      required this.title,
      this.confirm,
      this.cancel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                color: AppTheme.warning),
            height: size.height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  child: const Icon(
                    Icons.priority_high_sharp,
                    color: AppTheme.white,
                  ),
                ),
                const TextWidget(
                  title: 'Mensaje de Advertencia',
                  color: AppTheme.white,
                  fontWeight: FontWeight.bold,
                )
              ],
            )),
        const SizedBox(height: 25),
        isTitle == true
            ? titleAlerts( title: title, color: AppTheme.warning)
            : const SizedBox(),
        isTitle == true
            ? SizedBox(height: size.height * 0.015)
            : const SizedBox(),
        messageAlerts(size, message: message!),
        SizedBox(height: size.height * 0.025),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (cancel != null) ...{
              OutlinedButtonWidget(
                text: 'Cancelar',
                onPressed: cancel,
                color: AppTheme.warning,
                width: size.width * 0.4,
              ),
              SizedBox(width: size.width * 0.03),
            },
            FilledButtonWidget(
                borderRadius: 5,
                width: size.width * 0.4,
                textButtonColor: AppTheme.white,
                color: AppTheme.warning,
                text: 'Aceptar',
                onPressed: confirm ??
                    () {
                      final fp = Provider.of<FunctionalProvider>(context,
                          listen: false);
                      fp.dismissAlert(key: keyToClose);
                    }),
          ],
        ),
        SizedBox(height: size.height * 0.02),
      ],
    );
  }
}


