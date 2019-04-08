import 'package:flutter/material.dart';
import '../service/service_methods.dart';
import '../model/details_model.dart';
import 'dart:convert';

class DetailInfoProvide with ChangeNotifier{
  DetailsModel goodsInfo = null;

  //get goods info
  getGoodsInfo(String id){
    var formData = {'goodId': id};

    request('getGoodDetailById',formData: formData).then((val){
      var responseData = json.decode(val.toString());
      print(responseData);

      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners(); 
    });
  }
}

