import 'package:flutter/material.dart';
import '../service/service_methods.dart';
import 'dart:convert';
import '../model/Category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/child_category.dart';



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
            CategoryListNav(), //左侧导航
            Column(
              children: <Widget>[
                _rightCategoryNavi() //右侧导航 头部 


              ],
            ),

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
  var clickIndex = 0;//是否点击标记
  @override
  void initState() {
    super.initState();
    _getCategory();
    
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
    bool isClick = false;
    isClick = (index == clickIndex)?true:false;

    return InkWell(
      onTap: (){

        setState(() {
          clickIndex = index;
        });

        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(top: 10, bottom: 20),
        decoration: BoxDecoration(
          color: isClick?Color.fromRGBO(236, 236, 236, 1.0):Colors.white,
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

    setState(() {
      list = category.data;
    });
    Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto);
  // list.data.forEach(
  //   (item)=>print(item.mallCategoryName)
  // );
  //输出大类的名称
});
}
}

class _rightCategoryNavi extends StatefulWidget {
  @override
  __rightCategoryNaviState createState() => __rightCategoryNaviState();
}

class __rightCategoryNaviState extends State<_rightCategoryNavi> {

// List list = ['全部','名酒','宝丰','北京二锅头','茅台','五粮液','衡水老白干'];
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context,child,childCategory){
        return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.black12,width: 1)
        ),
      ),
      height: ScreenUtil().setHeight(80),
      width: ScreenUtil().setWidth(570),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: childCategory.childCategoryList.length,
        itemBuilder: (context,index){
          return _rightInkWell(childCategory.childCategoryList[index]);
        },
        ),
      );
      },
    );
    
    
  }

  Widget _rightInkWell(BxMallSubDto item){
    return InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
}