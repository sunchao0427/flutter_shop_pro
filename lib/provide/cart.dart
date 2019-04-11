import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cart_Info_Model.dart';

class CartProvide extends ChangeNotifier{

  String cartString = '[]';
  
  List<CartInfoModel> modelList = [];


  save(goodsId,goodsName,count,price,images)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
  
  cartString = prefs.getString("cartInfo");
  var temp = cartString==null?[]:json.decode(cartString.toString());

  //记录商品数量的索引
  List<Map> tempList = (temp as List).cast();

  bool isHave = false;
  int ival = 0;

  tempList.forEach((item){
    if (item['goodsId'] == goodsId) {
      tempList[ival]['count'] = item['count'] + 1;
      modelList[ival].count ++;
      isHave = true;
    } 
    ival++;
  });

  if(!isHave){ //没有该商品就添加到tempList中
  Map<String,dynamic> goodsList = {
      'goodsId':goodsId,
      'goodsName':goodsName,
      'count':count,
      'price':price,
      'images':images
    };
    tempList.add(goodsList);
    modelList.add(CartInfoModel.fromJson(goodsList));
  }

  cartString = json.encode(tempList).toString();
  print(cartString);
  print('字符串。。。。。。。。。。。。。。。。${cartString}');
  print('数据模型》》》。》》》》》》》》》》》${modelList}');

  prefs.setString('cartInfo', cartString);
  notifyListeners();
  }

  remove()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
  
    prefs.remove('cartInfo');

    print('清空购物车--------------》');
    notifyListeners();
  }

  getCartInfo()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');

    modelList = [];

    if (cartString == null) {
      modelList = [];
    } else {
      List<Map> tempList = (json.encode(cartString.toString()) as List).cast();
      tempList.forEach((item){
        modelList.add(CartInfoModel.fromJson(item));
      });
    }
    

  }


}