// import 'package:animate_do/animate_do.dart';
// import 'package:back_button_interceptor/back_button_interceptor.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertest/env/theme/app_theme.dart';
// import 'package:fluttertest/modules/Login/page/login_page.dart';
// import 'package:fluttertest/modules/my_requests/page/my_request.dart';
// import 'package:fluttertest/shared/helpers/global_helper.dart';
// import 'package:fluttertest/shared/providers/functional_provider.dart';
// import 'package:fluttertest/shared/providers/navegation_verify_provider.dart';
// import 'package:fluttertest/shared/widgets/alert_modal.dart';
// import 'package:fluttertest/shared/widgets/alert_template.dart';
// import 'package:fluttertest/shared/widgets/page_modal.dart';
// import 'package:provider/provider.dart';

// class Layout extends StatefulWidget {
//   final Widget child;
//   final String nameInterceptor;
//   final bool backPageView;
//   final bool haveLogoCenter;
//   final GlobalKey<State<StatefulWidget>>? keyDismiss;
//   final String title;
//   final String? subtitle;
//   final bool? isMessageWelcome;
//   final bool isLoginPage;
//   final bool isHomePage;
//   final bool isVerificationModule;
//   final bool isMenuPage;
//   final bool haveFooterLogo;
//   final bool isRegister;
//   final void Function()? actionToBack;
//   final bool isScrolleabe;
//   final bool showBottomNavBar;

//   const Layout({
//     super.key,
//     required this.child,
//     required this.nameInterceptor,
//     this.keyDismiss,
//     this.haveLogoCenter = true,
//     this.backPageView = false,
//     this.title = '',
//     this.subtitle,
//     this.isLoginPage = false,
//     this.haveFooterLogo = true,
//     this.actionToBack,
//     this.isHomePage = false,
//     this.isMenuPage = false,
//     this.isMessageWelcome = true,
//     this.isVerificationModule = false,
//     this.isRegister = false,
//     required this.isScrolleabe,
//     this.showBottomNavBar = false,
//   });

//   @override
//   State<Layout> createState() => _LayoutState();
// }

// class _LayoutState extends State<Layout> {
//   ScrollController _scrollController = ScrollController();
//   bool alertModalBool = true;

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollController = ScrollController();
//       BackButtonInterceptor.add(_backButton,
//           name: widget.nameInterceptor, context: context);
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     BackButtonInterceptor.remove(_backButton);
//     alertModalBool = false;
//     super.dispose();
//   }

//   Future<bool> _backButton(bool button, RouteInfo info) async {
//     if (mounted) {
//       final fp = Provider.of<FunctionalProvider>(context, listen: false);
//       if (widget.nameInterceptor.isEmpty) {
//         if (widget.keyDismiss == null) return false;
//         if (fp.pages.isNotEmpty || (fp.pages.last.key != widget.keyDismiss)) {
//           return false;
//         }
//         null;
//         return true;
//       } else {
//         // if (widget.requiredStack) {
//         //   if (button) return false;
//         //   if (fp.pages.isNotEmpty) {
//         //     if (widget.keyDismiss != null) {
//         //       fp.dismissPage(key: widget.keyDismiss!);
//         //       return true;
//         //     } else {
//         //       fp.dismissLastPage();
//         //     }
//         //   } else {
//         //     widget.isHomePage
//         //         ? _modalSessionClose()
//         //         : widget.haveLogoCenter
//         //             ? Navigator.pushAndRemoveUntil(
//         //                 context,
//         //                 GlobalHelper.navigationFadeIn(
//         //                     context, const LoginPage()),
//         //                 (route) => false)
//         //             : _modalSessionClose();
//         //     return true;
//         //   }
//         // }

//         if (!button) {
//           if (widget.keyDismiss != null) {
//             fp.dismissPage(key: widget.keyDismiss!);
//           } else {
//             fp.dismissLastPage();
//           }
//         }

//         if (button) return false;

//         setState(() {});
//       }
//       return true;
//     }

//     return true;
//   }

//   void _modalSessionClose() {
//     final fp = Provider.of<FunctionalProvider>(context, listen: false);
//     final keyAlertRemoveSession = GlobalHelper.genKey();

//     fp.showAlert(
//       closeAlert: false,
//       key: keyAlertRemoveSession,
//       content: AlertGeneric(
//         content: ConfirmContent(
//           message:
//               "Estás a punto de cerrar la sesión actual. ¿Deseas continuar?",
//           cancel: () {
//             fp.dismissAlert(key: keyAlertRemoveSession);
//           },
//           confirm: () async {
//             fp.clearAllAlert();
//             fp.setUserName('');
//             if (context.mounted) {
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   GlobalHelper.navigationFadeIn(context, const LoginPage()),
//                   (route) => false);
//             }
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final fp = Provider.of<FunctionalProvider>(context, listen: false);
//     final nvp = Provider.of<NavegationVerifyProvider>(context, listen: true);

//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: AppTheme.white,
//       body: Stack(
//         children: [
//           CustomScrollView(
//             controller: _scrollController,
//             physics: widget.isScrolleabe
//                 ? const NeverScrollableScrollPhysics()
//                 : const ClampingScrollPhysics(),
//             slivers: [
//               SliverFillRemaining(
//                 child: FadeIn(
//                   delay: const Duration(milliseconds: 500),
//                   child: PopScope(
//                     canPop: false,
//                     child: widget.child,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           if (widget.showBottomNavBar)
//             Positioned(
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: BottomNavigationBar(
//                 currentIndex: 0,
//                 onTap: (index) {
//                       switch (index) {
//                         case 0:
//                           fp.clearAllPages();
//                           break;
//                         case 1:
//                           final MyRequestsPageKey = GlobalHelper.genKey();
//                           fp.addPage(
//                               key: MyRequestsPageKey,
//                               content: MyRequestsPage(
//                                   globalKey: MyRequestsPageKey));
//                           break;
//                       }
//                     },
//                 selectedItemColor: AppTheme.primaryDark,
//                 unselectedItemColor: Colors.grey,
//                 items: const [
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.home_outlined),
//                     label: 'Inicio',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.warning_amber_outlined),
//                     label: 'Mis solicitudes',
//                   ),
//                 ],
//               ),
//             ),
//           const AlertModal(),
//         ],
//       ),
//     );
//   }
// }