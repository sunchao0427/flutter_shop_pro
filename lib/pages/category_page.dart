import 'package:flutter/material.dart';
import '../service/service_methods.dart';
import 'dart:convert';
import '../model/Category.dart';
import '../model/CategoryGoodsList.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/child_category.dart';
import '../provide/category_goods_list.dart';

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
      appBar: AppBar(
        title: Text(
          '商品分类',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            CategoryListNav(), //左侧导航
            Column(
              children: <Widget>[
                _rightCategoryNavi(), //右侧导航 头部
                CategoryGoodsList()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//左侧大类导航
class CategoryListNav extends StatefulWidget {
  @override
  _CategoryListNavState createState() => _CategoryListNavState();
}

class _CategoryListNavState extends State<CategoryListNav> {
  List list = [];
  var clickIndex = 0; //是否点击标记
  @override
  void initState() {
    super.initState();
    _getCategory();
    _getCategoryGoodsList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return _leftInkWell(index);
          }),
    );
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == clickIndex) ? true : false;

    return InkWell(
      onTap: () {
        setState(() {
          clickIndex = index;
        });

        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context)
            .getChildCategory(childList, categoryId);
        _getCategoryGoodsList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(top: 10, bottom: 20),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12),
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

  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);

      setState(() {
        list = category.data;
      });
      Provide.value<ChildCategory>(context)
          .getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
      // list.data.forEach(
      //   (item)=>print(item.mallCategoryName)
      // );
      //输出大类的名称
    });
  }

//获取右侧商品列表调试参数接口
  void _getCategoryGoodsList({String categoryId}) {
    var data = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': "",
      'page': 1
    };

    request("getMallGoods", formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provide.value<CategoryGoodsListProvide>(context)
          .getCategoryGoodsList(goodsList.data);
      // setState(() {
      // list = goodsList.data;
      // });
      // print('xxxxxxxxxx==============>>>>>>>>>>>>>>>>>>>${goodsList.data[0].goodsName}');
      // print("hahhahahhaahaahahah${val}");
    });
  }
}

//右侧小类导航
class _rightCategoryNavi extends StatefulWidget {
  @override
  __rightCategoryNaviState createState() => __rightCategoryNaviState();
}

class __rightCategoryNaviState extends State<_rightCategoryNavi> {
// List list = ['全部','名酒','宝丰','北京二锅头','茅台','五粮液','衡水老白干'];
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategory) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
          ),
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index) {
              return _rightInkWell(
                  index, childCategory.childCategoryList[index]);
            },
          ),
        );
      },
    );
  }

  Widget _rightInkWell(int index, BxMallSubDto item) {
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategory>(context).childIndex)
        ? true
        : false;

    return InkWell(
      onTap: () {
        Provide.value<ChildCategory>(context).changeChildIndex(index,item.mallSubId);
        _getCategoryGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: isClick ? Colors.pink : Colors.black),
        ),
      ),
    );
  }

  //获取小类的商品列表
  void _getCategoryGoodsList(String categorySubId) {
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': categorySubId,
      'page': 1
    };

    request("getMallGoods", formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Provide.value<CategoryGoodsListProvide>(context)
            .getCategoryGoodsList([]);
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getCategoryGoodsList(goodsList.data);
      }
    });
  }
}

//商品列表
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  // var list = [];
  @override
  void initState() {
    // _getCategoryGoodsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        if (data.categoryGoodsList.length> 0) {
          return Expanded(
          child: Container(
            width: ScreenUtil().setWidth(570),
            child: ListView.builder(
              itemCount: data.categoryGoodsList.length,
              itemBuilder: (context, index) {
                return _goodsList(data.categoryGoodsList, index);
              },
            ),
          ),
        );
        } else {
          return Text('暂时没有该类商品');
        }
        
      },
    );
  }

//调试参数接口移除，放到左侧leftNavi的onTap方法中

//商品拆分组组件 图片  标题  价格
  Widget _goodsImage(List newList, int index) {
    // WidgetBuilder(context,index){
    return Container(
      width: ScreenUtil().setWidth(200),
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Image.network(newList[index].image),
    );
    // }
  }

  Widget _goodsName(List newList, int index) {
    // WidgetBuilder(Conext,index){
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        '${newList[index].goodsName}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28), color: Colors.black),
      ),
    );
    // }
  }

  Widget _goodsPrice(List newList, int index) {
    // WidgetBuilder(context,index){
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: ScreenUtil().setWidth(370),
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          Text('价格:¥${newList[index].presentPrice}',
              style: TextStyle(
                  color: Colors.pink, fontSize: ScreenUtil().setSp(26))),
          Text(
            '¥${newList[index].oriPrice}',
            style: TextStyle(
                color: Colors.black26, decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
    // }
  }

//组合组件为整体
  Widget _goodsList(List newList, int index) {
    // WidgetBuilder(context,index){
    return InkWell(
      onTap: () {},
      child: Container(
        // width: ScreenUtil().setWidth(570),
        // height: ScreenUtil().setHeight(300),
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1.0, color: Colors.black12))),
        child: Row(
          children: <Widget>[
            _goodsImage(newList, index),
            Column(
              children: <Widget>[
                _goodsName(newList, index),
                _goodsPrice(newList, index)
              ],
            )
          ],
        ),
      ),
    );

    // }
  }
}
