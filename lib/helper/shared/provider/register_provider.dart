import 'package:flutter/material.dart';

class registerProvider extends ChangeNotifier{
  late bool isLoading=false;
  void changeLoading(bool isloading){
    isLoading=isloading;
    notifyListeners();
  }
}