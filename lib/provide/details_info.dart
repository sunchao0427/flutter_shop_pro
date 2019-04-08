import 'package:flutter/material.dart';
import '../service/service_methods.dart';
import '../model/details_model.dart';
import 'dart:convert';

class DetailInfoProvide with ChangeNotifier{

  DetailsModel goodsInfo = null;
  bool isLeft = true;
  bool isRight = false;

//自定义tabBar使用的方法
  changeTabBar(String changeState){
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }

  //get goods info
  getGoodsInfo(String id)async{
    var formData = {'goodId': id};

    await request('getGoodDetailById',formData: formData).then((val){
      var responseData = json.decode(val.toString());
      print(responseData);

      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners(); 
    });
  }
}

