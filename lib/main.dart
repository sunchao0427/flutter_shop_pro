import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import './provide/details_info.dart';
import 'package:fluro/fluro.dart';
import './routers/application.dart';
import './routers/routers.dart';
import './provide/cart.dart';

void main(){
  
  var counter = Counter();
  var provides = Providers();
  var childCategory = ChildCategory();
  var categoryGoodsList = CategoryGoodsListProvide();
  var detailInfoProvide = DetailInfoProvide();
  var cartProvide = CartProvide();
  

  provides..provide(Provider<Counter>.value(counter));
  provides..provide(Provider<ChildCategory>.value(childCategory));
  provides..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsList));
  provides..provide(Provider<DetailInfoProvide>.value(detailInfoProvide));
  provides..provide(Provider<CartProvide>.value(cartProvide));
  runApp(ProviderNode(child:MyApp(),providers:provides));
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final route = new Router();
    Routes.configureRoutes(route);
    Application.router = route;

    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
        home: IndexPage(),
      ),
    );
  }
}