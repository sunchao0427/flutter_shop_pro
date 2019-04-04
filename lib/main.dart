import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';


void main(){
  
  var counter = Counter();
  var provides = Providers();
  var childCategory = ChildCategory();
  var categoryGoodsList = CategoryGoodsListProvide();

  provides..provide(Provider<Counter>.value(counter));
  provides..provide(Provider<ChildCategory>.value(childCategory));
  provides..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsList));
  runApp(ProviderNode(child:MyApp(),providers:provides));
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
        home: IndexPage(),
      ),
    );
  }
}