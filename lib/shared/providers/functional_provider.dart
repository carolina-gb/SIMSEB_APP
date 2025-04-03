import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertest/env/theme/app_theme.dart';
import 'package:fluttertest/shared/widgets/alert_template.dart';

class FunctionalProvider extends ChangeNotifier {
  List<Widget> alerts = [];
  List<Widget> pages = [];
  String userName = '';
  String registerUserName = '';
  String registerEmail = '';
  bool modeDraggable = false;
  String? currentPage;
  ScrollController scrollController = ScrollController();

  bool callService = false;

  int timeWait = 0;
  int? saveTimeWait;

  showAlert(
      {required GlobalKey key,
      required Widget content,
      bool closeAlert = false,
      bool animation = true,
      double padding = 20}) {
    final newAlert = Container(
        key: key,
        color: AppTheme.transparent,
        child: AlertTemplate(
            content: content,
            keyToClose: key,
            dismissAlert: closeAlert,
            animation: animation,
            padding: padding));

      alerts.add(newAlert);

    notifyListeners();
  }

  int getTimeMailVerification() {
    if (timeWait == 0) {
      timeWait = 10;
    } else if (timeWait < 180) {
      timeWait += (timeWait < 30) ? 20 : 30;
    } else {
      timeWait = 180;
    }

    notifyListeners();
    return timeWait;
  }

  void setLastTimeMailVerification(int time) {
    saveTimeWait = time;
    notifyListeners();
  }

  addPage({required GlobalKey key, required Widget content}) {
    currentPage = content.runtimeType.toString();
    log(currentPage!);
    pages.add(content);
    notifyListeners();
  }

  dismissAlert({required GlobalKey key}) {
    alerts.removeWhere((alert) => key == alert.key);
    notifyListeners();
  }

  dismissPage({required GlobalKey key}) {
    pages.removeWhere((page) => key == page.key);
    currentPage = '';
    notifyListeners();
  }

  dismissLastPage() {
    pages.removeLast();
    notifyListeners();
  }

  clearAllAlert() {
    alerts = [];
    notifyListeners();
  }

  clearAllPages() {
    pages = [];
    notifyListeners();
  }

  setUserName(String name) {
    userName = name;
    notifyListeners();
  }

  getUserName() {
    return userName;
  }

  setRegisterUserName(String name) {
    registerUserName = name;
    notifyListeners();
  }

  getRegisterUserName() {
    return registerUserName;
  }

  setRegisterEmail(String email) {
    registerEmail = email;
    notifyListeners();
  }

  getRegisterEmail() {
    return registerEmail;
  }

  deleteDataRegister() {
    registerUserName = '';
    registerEmail = '';
    notifyListeners();
  }

  bool isCurrentPage(String pageName) {
    return currentPage == pageName;
  }

  moveToHome() {
    currentPage = '';
    pages.clear();
    notifyListeners();
  }

  changeModeDraggable() {
    modeDraggable = !modeDraggable;
    notifyListeners();
  }

  changeCallService(bool changeCallService) {
    callService = changeCallService;
    notifyListeners();
  }
}
