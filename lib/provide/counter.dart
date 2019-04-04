import 'package:flutter/material.dart';
// import 'package:provide/provide.dart';

class Counter with ChangeNotifier{
  int value = 0;
  increment(){
    value++;
    notifyListeners();//局部刷新widget
  }
}