# flutter_shop_pro

A Flutter project about shop.
> ### 例子图片：

[<img src="https://github.com/sunchao0427/flutter_shop_pro/blob/master/res/android_main.png" width="270" height="480" alt="Brand-first shopping design" align="left">](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery/lib/demo/animation)
<img src="https://github.com/sunchao0427/flutter_shop_pro/blob/master/res/android_category1.png" width="270" height="480" alt="Fitness app design">



[<img src="https://github.com/sunchao0427/flutter_shop_pro/blob/master/res/iPhone_main.png" width="270" height="584" alt="Brand-first shopping design" align="left">](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery/lib/demo/animation)
<img src="https://github.com/sunchao0427/flutter_shop_pro/blob/master/res/iPhone_category1.png" width="270" height="584" alt="Fitness app design">

> ### 涉及的第三方库

***

#### 1、[Dart Http请求库dio](<https://github.com/flutterchina/dio>)

```dart
Response response = await Dio().get("http://www.baidu.com");
```

#### 2、[Dart 轮播器插件 flutter_swiper](<https://github.com/best-flutter/flutter_swiper>)

```dart
child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              Application.router.navigateTo(
                context, 
                "detail?id=${swiperDataList[index]['goodsId']}");
            },
            child: Image.network(
              "${swiperDataList[index]['image']}",
              fit: BoxFit.fill),
          	);
        },
        itemCount: swiperDataList.length,  //设置数据的长度
        pagination: SwiperPagination(),		
        autoplay: true,
      ),
```



#### 3、[Dart屏幕适配插件flutter_screenutil](<https://github.com/OpenFlutter/flutter_screenutil>)

```Dart
return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
  	.....
```



####4、[Flutter服务访问（拨打电话、发送邮件、信息跳转）插件请求器url_launcher](<https://pub.dartlang.org/packages/url_launcher>)

```dart
void _launchUrl() async {
    String url = 'tel:' + leaderPhone; //url中需要添加需要访问服务的类型
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url不能打开，异常';
    }
  }
```



#### 5、[flutter刷新插件flutter_easyrefresh](<https://github.com/xuelongqy/flutter_easyrefresh>)

```dart
return EasyRefresh(
                child: ListView(
                  children: <Widget>[
                    ...      //嵌套在需要刷新的widget外层
                  ]
```



####6、[状态管理Google亲儿子 provide](<https://github.com/google/flutter-provide>)

```dart
//1、建立专门的provide类 Counter 并混入ChangeNotifier 类内部编写状态变化逻辑
import 'package:flutter/material.dart';
// import 'package:provide/provide.dart';

class Counter with ChangeNotifier{
  int value = 0;
  increment(){
    value++;
    notifyListeners();//局部刷新widget
  }
}

//2、在main函数中进行声明并实例化对应的provide
void main(){ 
  var counter = Counter();
  var provides = Providers();
 
  provides..provide(Provider<Counter>.value(counter));
  runApp(ProviderNode(child:MyApp(),providers:provides));
  }

//3、在页面中引入该文件和库文件 即可使使用
child: Provide<Counter>(
          builder: (context,child,val){  //此方法内参数固定，不需要修改
            return Text(
            '${counter.value}',
            style: Theme.of(context).textTheme.display1,
          );
          },
        ),
```

#### 7、[flutter清提示插件fluttertoast](<https://github.com/PonnamKarthik/FlutterToast>)

```dart
if (goodsList.data == null) {
        Fluttertoast.showToast(
          backgroundColor: Colors.pink,
          msg: '没有更多数据了',
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          fontSize: 16.0
        );
```

#### 8、[路由管理-fluro](<https://github.com/theyakka/fluro>) 

使用方法：商品静态化—>书写Handler—>总体route的设置，建立静态全局router 与handle的联系—>main函数中总体的注入，即将application中的声明的静态的router赋值给初始化的router，并在MaterialApp中设置其generator—>使用，直接使用application.router.navigateTo(参数)

#### 9、[HTML插件flutter_html](<https://github.com/Sub6Resources/flutter_html>)

使用方法：

```dart
return Html(
  data:goodsDetail
);
```

> ### 使用Flutter 

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
