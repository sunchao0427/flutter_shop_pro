import 'package:flutter/material.dart';
import '../model/Category.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;//子类高亮索引 0 表示全部

  //大类切换效果
  getChildCategory(List<BxMallSubDto> list){

    childIndex = 0;//切换归零处理
    BxMallSubDto all = BxMallSubDto();

    all.mallSubId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';
    all.mallCategoryId = '00';

  childCategoryList = [all];
  childCategoryList.addAll(list);

    // childCategoryList = list;
    notifyListeners();
  }


  //改变小类切换效果
  changeChildIndex(index) {
    childIndex = index;
    notifyListeners();
  }
  
}