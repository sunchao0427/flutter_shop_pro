import 'package:flutter/material.dart';
import '../model/Category.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;//子类高亮索引 0 表示全部
  String subId = '';//子类
  String categoryId = '4';//初始化为白酒的categoryId = 4;
  int page = 1; //列表页数
  String noMoreText = '';//刷新文字

  //大类切换效果
  getChildCategory(List<BxMallSubDto> list,String id){
    page = 1;
    noMoreText = '';

    childIndex = 0;//切换归零处理
    categoryId = id;//切换的时候就把该id赋值给状态管理器
    
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
  changeChildIndex(index,String id) {

    page = 1;
    noMoreText = '';

    childIndex = index;
    subId = id;
    notifyListeners();
  }

//页数增加
  increasePage(){
    page++;
  
  }
  //改变nomore显示的文字
  changeNoMoreText(String text){
    noMoreText = text;
    notifyListeners();
  }

}