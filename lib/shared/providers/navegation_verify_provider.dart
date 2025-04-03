import 'package:flutter/material.dart';

class NavegationVerifyProvider extends ChangeNotifier {

  bool show = true;

  int selectedOption = 0;

  showChange(bool change){
    show = change;
    notifyListeners();
  }

  changeSelectedOption(int index){
    selectedOption = index;
    notifyListeners();
  }
  
}