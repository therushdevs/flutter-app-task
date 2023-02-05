import 'package:flutter/material.dart';

class StateProvider extends ChangeNotifier{
  var _homeScreenData = [];

  get homeScreenData => _homeScreenData;

  //Adding api fetched data in the variable.
  void addHomeScreenData(var data){
    _homeScreenData = data;
    notifyListeners();
  }
}