import 'package:flutter/material.dart';

class themeProvider extends ChangeNotifier {
  bool isLight = true;
  changeTheme() {
    isLight = !isLight;
    notifyListeners();
  }
}
