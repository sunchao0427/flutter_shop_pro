import 'package:flutter/material.dart';
import '../service/service_methods.dart';
import 'dart:convert';
import '../model/Category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CategoryPage extends StatefulWidget {

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

// void _getCategory()async{
// await request('getCategory').then((val){
//   var data = json.decode(val.toString());
//   CategoryModel category = CategoryModel.fromJson(data['data']);


//   // list.data.forEach(
//   //   (item)=>print(item.mallCategoryName)
//   // );
//   //输出大类的名称
// });
// }

  @override
  Widget build(BuildContext context) {
    // _getCategory();
    return Scaffold(
      appBar: AppBar(title: Text('商品分类',style: TextStyle(color: Colors.white),),),
      body: Center(
        child: Row(
          children: <Widget>[
            CategoryListNav()

          ],
        ),
      ),
    );
  }
}

class CategoryListNav extends StatefulWidget {
  @override
  _CategoryListNavState createState() => _CategoryListNavState();
}

class _CategoryListNavState extends State<CategoryListNav> {
  
  List list = [];

  @override
  void initState() {
    _getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().setWidth(180),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(width: 1,color: Colors.black12),
          ),
        ),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context,index){
            return _leftInkWell(index);
          }
        ),
    );
  }


  Widget _leftInkWell(int index){

    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(top: 10, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1,color: Colors.black12),
          ),
        ),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(26)),
          textAlign: TextAlign.center,
          ),

      ),
    );
  }

  void _getCategory()async{
    await request('getCategory').then((val){
    var data = json.decode(val.toString());
    CategoryModel category = CategoryModel.fromJson(data);

    list = category.data;
  // list.data.forEach(
  //   (item)=>print(item.mallCategoryName)
  // );
  //输出大类的名称
});
}


}