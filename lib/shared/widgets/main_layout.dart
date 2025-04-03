import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/modules/Login/page/login_page.dart';
import 'package:fluttertest/shared/helpers/global_helper.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:fluttertest/shared/widgets/alert_modal.dart';
import 'package:fluttertest/shared/widgets/alert_template.dart';
import 'package:fluttertest/shared/widgets/page_modal.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final String? nameInterceptor;
  final bool? backPageView;
  final bool requiredStack;
  final bool haveLogoCenter;
  final GlobalKey<State<StatefulWidget>>? keyDismiss;
  final String? title;
  final String? subtitle;
  final bool? isMessageWelcome;
  final bool isLoginPage;
  final bool? isHomePage;
  final bool? isVerificationModule;
  final bool? isMenuPage;
  final bool? haveFooterLogo;
  final bool? isRegister;
  final void Function()? actionToBack;

  const MainLayout({
    super.key,
    required this.child,
    this.nameInterceptor,
    this.keyDismiss,
    this.requiredStack = true,
    this.haveLogoCenter = true,
    this.backPageView = false,
    this.title = '',
    this.subtitle,
    this.isLoginPage = false,
    this.haveFooterLogo = true,
    this.actionToBack,
    this.isHomePage = false,
    this.isMenuPage = false,
    this.isMessageWelcome = true,
    this.isVerificationModule = false,
    this.isRegister = false,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  ScrollController _scrollController = ScrollController();
  bool alertModalBool = true;

  // final keyModalProfile = GlobalHelper.genKey();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController = ScrollController();
      BackButtonInterceptor.add(_backButton,
          name: widget.nameInterceptor, context: context);
    });
    super.initState();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(_backButton);
    alertModalBool = false;
    super.dispose();
  }

  Future<bool> _backButton(
    bool button,
    RouteInfo info
  ) async {
    if (mounted) {
      final fp = Provider.of<FunctionalProvider>(context, listen: false);
      if (widget.nameInterceptor == null) {
        if (widget.keyDismiss == null) return false;
        if (fp.pages.isNotEmpty || (fp.pages.last.key != widget.keyDismiss)) {
          return false;
        }
        null;
        return true;
      } else {
        if (widget.requiredStack) {
          if (button) return false;
          if (fp.pages.isNotEmpty) {
            if (widget.keyDismiss != null) {
              fp.dismissPage(key: widget.keyDismiss!);
              return true;
            } else {
              fp.dismissLastPage();
            }
          } else {
            widget.isHomePage!
                ? _modalSessionClose()
                : widget.haveLogoCenter
                    ? Navigator.pushAndRemoveUntil(
                        context,
                        GlobalHelper.navigationFadeIn(
                            context, const LoginPage()),
                        (route) => false)
                    : _modalSessionClose();
            return true;
          }
        }

        if (!button) {
          if (widget.keyDismiss != null) {
            fp.dismissPage(key: widget.keyDismiss!);
          } else {
            fp.dismissLastPage();
          }
        }

        if (button) return false;

        setState(() {});
      }
      return true;
    }

    return true;
  }

  void _modalSessionClose() {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    final keyAlertRemoveSession = GlobalHelper.genKey();

    fp.showAlert(
      closeAlert: false,
      key: keyAlertRemoveSession,
      content: AlertGeneric(
        content: ConfirmContent(
          message:
              "Estás a punto de cerrar la sesión actual. ¿Deseas continuar?",
          cancel: () {
            fp.dismissAlert(key: keyAlertRemoveSession);
          },
          confirm: () async {
            fp.clearAllAlert();
            fp.setUserName('');
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  GlobalHelper.navigationFadeIn(context, const LoginPage()),
                  (route) => false);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    // final nvp = Provider.of<NavegationVerifyProvider>(context, listen: true);

    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppTheme.white,
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              physics: widget.isLoginPage
                  ? const NeverScrollableScrollPhysics()
                  : const ClampingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  leading: !widget.isHomePage!
                      ? Visibility(
                          visible: widget.backPageView!,
                          child: InkWell(
                            child: const Icon(Icons.arrow_back_ios_new,
                                color: AppTheme.white),
                            onTap: () {
                              log(widget.keyDismiss.toString());
                              widget.actionToBack != null
                                  ? widget.actionToBack!()
                                  : widget.keyDismiss != null
                                      ? fp.dismissPage(key: widget.keyDismiss!)
                                      : _modalSessionClose();

                              setState(() {});
                            },
                          ),
                        )
                      : InkWell(
                          child: const Icon(
                            Icons.logout,
                            color: AppTheme.white,
                            size: 10,
                          ),
                          onTap: () => _modalSessionClose(),
                        ),
                  toolbarHeight: widget.haveLogoCenter
                      ? size.height * 0.2
                      : widget.isHomePage! || widget.isMenuPage!
                          ? widget.subtitle != null
                              ? size.height * 0.1
                              : size.height * 0.08
                          : size.height * 0.17,
                  snap: false,
                  pinned: true,
                  forceElevated: true,
                  automaticallyImplyLeading: false,
                  floating: false,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(0))),
                  backgroundColor: AppTheme.positiveMedium,
                  centerTitle: true,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(text: widget.title),
                          style: TextStyle(
                              color: AppTheme.white,
                              fontSize: widget.isHomePage!
                                  ? 24
                                  : widget.isMenuPage!
                                      ? 24
                                      : 18),
                        ),
                        Visibility(
                          visible: widget.subtitle != null,
                          child: Column(children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text.rich(
                              TextSpan(text: widget.subtitle),
                              style: const TextStyle(
                                  color: AppTheme.white, fontSize: 15),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  // flexibleSpace: Stack(
                  //     fit: StackFit.expand,
                  //     clipBehavior: Clip.none,
                  //     alignment: Alignment.center,
                  //     children: [
                  //       Visibility(
                  //         visible: widget.haveLogoCenter,
                  //         child: Positioned(
                  //             top: size.height * 0.17,
                  //             child: Padding(
                  //               padding: EdgeInsets.symmetric(
                  //                   horizontal: size.width * 0.32),
                  //               child: drawerWidgetLogo(context),
                  //             )),
                  //       ),
                  //     ])
                ),
                SliverToBoxAdapter(
                  child: FadeIn(
                    delay: const Duration(milliseconds: 500),
                    child: PopScope(
                      canPop: false,
                      child: widget.child,
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  fillOverscroll: false,
                  child: Stack(children: [
                    Positioned(
                      bottom: -50,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: size.width * 0.30,
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                        ),
                        child: Text('data'),
                      ),
                    ),
                  ]),
                )
              ],
            ),
            if (widget.requiredStack) const PageModal(),
            if (widget.requiredStack) const AlertModal(),
          ],
        ),
      ),
    );
  }
}
