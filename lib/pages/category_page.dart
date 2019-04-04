import 'package:flutter/material.dart';
import '../service/service_methods.dart';
import 'dart:convert';
import '../model/Category.dart';


class CategoryPage extends StatefulWidget {

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

void _getCategory()async{
await request('getCategory').then((val){
  var data = json.decode(val.toString());
  CategoryBigListModel list = CategoryBigListModel.fromJson(data['data']);
  list.data.forEach(
    (item)=>print(item.mallCategoryName)
  );
  //输出大类的名称
});
}

  @override
  Widget build(BuildContext context) {
    _getCategory();
    return Container(
      child: Center(
        child: Text('分类页面'),
      ),
      
    );
  }
}