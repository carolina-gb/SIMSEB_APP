import 'dart:developer';
import 'package:flutter/material.dart';

// Paso 1: Se crea una clase para almacenar la información de la página.
class PageInfo {
  final GlobalKey key;
  final Widget widget;
  final String title;
  final bool showBottomNavBar;

  PageInfo({
    required this.key,
    required this.widget,
    this.title = '',
    this.showBottomNavBar = false,
  });
}

class FunctionalProvider extends ChangeNotifier {
  String? userName;
  String? currentPage;
  String? previousPage;
  // Paso 2: La lista ahora almacena objetos PageInfo.
  List<PageInfo> pages = [];
  List<Widget> alerts = [];

  // Paso 3: addPage ahora acepta la configuración de la página.
  addPage({
    required GlobalKey key,
    required Widget content,
    String title = '',
    bool showBottomNavBar = false,
  }) {
    currentPage = content.runtimeType.toString();
    log(currentPage!);
    final pageInfo = PageInfo(
      key: key,
      widget: content,
      title: title,
      showBottomNavBar: showBottomNavBar,
    );
    pages.add(pageInfo);
    log(pages.toString());
    notifyListeners();
  }

  // Paso 4: Los métodos de borrado se actualizan para funcionar con la nueva lista.
  dismissLastPage() {
    if (pages.isNotEmpty) {
      pages.removeLast();
      currentPage =
          pages.isNotEmpty ? pages.last.widget.runtimeType.toString() : null;
      notifyListeners();
    }
  }

  dismissPage({required GlobalKey key}) {
    pages.removeWhere((pageInfo) => pageInfo.key == key);
    currentPage =
        pages.isNotEmpty ? pages.last.widget.runtimeType.toString() : null;
    notifyListeners();
  }

  setUserName(String name) {
    userName = name;
    notifyListeners();
  }

  showAlert({required Widget content, required GlobalKey key, bool? closeAlert}) {
    alerts.add(content);
    notifyListeners();
  }

  dismissAlert({required GlobalKey key}) {
    if (alerts.isNotEmpty) {
      alerts.removeLast();
      notifyListeners();
    }
  }

  clearAllAlert() {
    alerts.clear();
    notifyListeners();
  }

  clearAllPages() {
    pages.clear();
    currentPage = null;
    notifyListeners();
  }
}
