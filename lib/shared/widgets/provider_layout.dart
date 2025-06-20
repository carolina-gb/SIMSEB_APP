import 'package:animate_do/animate_do.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/modules/Login/page/login_page.dart';
import 'package:fluttertest/modules/my_requests/page/my_request.dart';
import 'package:fluttertest/shared/helpers/global_helper.dart';
import 'package:fluttertest/shared/providers/functional_provider.dart';
import 'package:fluttertest/shared/providers/navegation_verify_provider.dart';
import 'package:fluttertest/shared/widgets/alert_modal.dart';
import 'package:fluttertest/shared/widgets/alert_template.dart';
import 'package:fluttertest/shared/widgets/title.dart';
import 'package:provider/provider.dart';

class ProviderLayout extends StatefulWidget {
  final Widget child;
  final String nameInterceptor;
  final bool backPageView;
  final bool requiredStack;
  final bool haveLogoCenter;
  final GlobalKey<State<StatefulWidget>>? keyDismiss;
  final String title;
  final String? subtitle;
  final bool? isMessageWelcome;
  final bool isLoginPage;
  final bool isHomePage;
  final bool isVerificationModule;
  final bool isMenuPage;
  final bool haveFooterLogo;
  final bool isRegister;
  final void Function()? actionToBack;
  final bool isScrolleabe;
  final bool showBottomNavBar;

  const ProviderLayout({
    super.key,
    required this.child,
    required this.nameInterceptor,
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
    required this.isScrolleabe,
    this.showBottomNavBar = false,
  });

  @override
  State<ProviderLayout> createState() => _ProviderLayoutState();
}

class _ProviderLayoutState extends State<ProviderLayout> {
  ScrollController _scrollController = ScrollController();
  bool alertModalBool = true;

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

  Future<bool> _backButton(bool button, RouteInfo info) async {
    if (mounted) {
      final fp = Provider.of<FunctionalProvider>(context, listen: false);
      if (widget.nameInterceptor.isEmpty) {
        if (widget.keyDismiss == null) return false;
        // Se corrige la lógica para acceder a la key del PageInfo
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
            widget.isHomePage
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
    final nvp = Provider.of<NavegationVerifyProvider>(context, listen: true);

    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppTheme.white,
        // El Consumer ahora envuelve el Stack para poder controlar sus hijos dinámicamente.
        body: Consumer<FunctionalProvider>(
          builder: (context, fp, child) {
            // Se determina la configuración a mostrar.
            // Si la pila de páginas está activa, se usa la configuración de la última página.
            // Si no, se usa la configuración por defecto del widget.
            final bool isPageStackActive = fp.pages.isNotEmpty;
            final PageInfo? currentPageInfo =
                isPageStackActive ? fp.pages.last : null;

            final String displayTitle = currentPageInfo?.title ?? widget.title;
            final bool displayBottomNavBar =
                currentPageInfo?.showBottomNavBar ?? widget.showBottomNavBar;

            return Stack(
              children: [
                // Contenido principal (la página base como HomePage)
                CustomScrollView(
                  controller: _scrollController,
                  physics: widget.isScrolleabe
                      ? const NeverScrollableScrollPhysics()
                      : const ClampingScrollPhysics(),
                  slivers: [
                    SliverVisibility(
                        visible: !widget.isHomePage,
                        sliver: SliverAppBar(
                          // El título ahora es dinámico
                          title: TitleWidget(
                            title: displayTitle,
                            fontSize: 35,
                          ),
                          backgroundColor: AppTheme.primaryDarkest,
                          centerTitle: true,
                        )),
                    SliverToBoxAdapter(
                      child: FadeIn(
                        delay: const Duration(milliseconds: 500),
                        child: PopScope(
                          canPop: false,
                          child: widget.child,
                        ),
                      ),
                    ),
                  ],
                ),
                // La barra de navegación inferior ahora es dinámica
                if (displayBottomNavBar)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: BottomNavigationBar(
                      currentIndex: 0,
                      onTap: (index) {
                        switch (index) {
                          case 0:
                            fp.clearAllPages();
                            break;
                          case 1:
                            final MyRequestsPageKey = GlobalHelper.genKey();
                            fp.addPage(
                                key: MyRequestsPageKey,
                                content: MyRequestsPage(
                                    globalKey: MyRequestsPageKey));
                            break;
                        }
                      },
                      backgroundColor: AppTheme.white,
                      selectedItemColor: AppTheme.primaryDark,
                      unselectedItemColor: Colors.grey,
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home_outlined),
                          label: 'Inicio',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.warning_amber_outlined),
                          label: 'Mis solicitudes',
                        ),
                      ],
                    ),
                  ),

                // Alertas (se mantienen igual)
                if (widget.requiredStack) const AlertModal(),

                // Renderiza la pila de páginas del provider.
                // Se mapea la lista de PageInfo para obtener solo los widgets.
                ...fp.pages.map((pageInfo) => pageInfo.widget).toList(),
              ],
            );
          },
        ),
      ),
    );
  }
}
