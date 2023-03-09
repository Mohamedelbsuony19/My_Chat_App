import 'package:flutter/material.dart';

class homeProvider extends ChangeNotifier {
  late bool isLoading = false;

  void changeLoading(bool isloading) {
    isLoading = isloading;
    notifyListeners();
  }
}
