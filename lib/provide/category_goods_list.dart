import 'package:flutter/material.dart';
import '../model/CategoryGoodsList.dart';

class CategoryGoodsListProvide with ChangeNotifier{
  List<CategoryGoodsData> categoryGoodsList = [];

  getCategoryGoodsList(List<CategoryGoodsData> list){

    categoryGoodsList = list;

    notifyListeners();
  }
}