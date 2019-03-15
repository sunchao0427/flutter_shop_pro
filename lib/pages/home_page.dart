import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import '../config/httpHeaders.dart';
import '../service/service_methods.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     getHttp();
//     return Scaffold(
//       appBar: new AppBar(title: Text('首页'),),
//       body: Center(
//         child: Text('首页界面'),
//       ),
//     );
//   }
//   void getHttp() async{//异步 与 await配合使用
//     try {
//       Response response;
//       response = await Dio().get("https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=MM");
//       return print(response);
//     } catch (e) {
//       return print(e);
//     }
//   }
// }
//=======================================Dio 请求测试
// class HomePage extends StatefulWidget {
//   final Widget child;

//   HomePage({Key key, this.child}) : super(key: key);

//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   TextEditingController typeController =TextEditingController();
//   String showText = '欢迎来到美好人间';
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//        child: Scaffold(
//          appBar: AppBar(title: Text('美好人间'),),
//          body: SingleChildScrollView(
//            child:Container(
//            child: Column(
//              children: <Widget>[
//                TextField(
//                controller: typeController,
//                decoration: InputDecoration(
//                  contentPadding: EdgeInsets.all(10.0),
//                  labelText: '类型',
//                  helperText: '输入类型',
//                ),
//                autofocus: false,//坑一个
//              ),
//              RaisedButton(
//                onPressed: _chooseAction,
//                child: Text('选择完毕'),
//              ),
//              Text(
//                showText,
//                overflow: TextOverflow.ellipsis,
//                maxLines: 1,
//              ),

//              ],
//            ),
//          ),
//          )
//        ),
//     );
//   }
// void _chooseAction() {
// print("正在选择喜欢的类型。。。。。。。。。。。。。。。。");

// if (typeController.text.toString() == '') {
//   showDialog(
//     context: context,
//     builder: (context)=>AlertDialog(title: Text('类型不存在'),)
//   );

// } else {
//   getHttp(typeController.text.toString()).then((val){
//     setState(() {
//       showText = val['data']['name'].toString();
//     });
//   });
// }

// }

//   Future getHttp(String TypeText) async{
//     try {
//       Response response;
//       var data = {'name':TypeText};
//       response = await Dio().get("https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian",
//       queryParameters: data
//       );
//       return response.data;
//     } catch (e) {
//       return print(e);
//     }
//   }

// }
//======================================伪造头文件进行请求
// class HomePage extends StatefulWidget {
//   final Widget child;

//   HomePage({Key key, this.child}) : super(key: key);

//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String showText = '还没有加载数据';
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//        child: Scaffold(
//          appBar: AppBar(title: Text('请求数据测试'),),
//          body: SingleChildScrollView(
//            child: Column(
//              children: <Widget>[
//                RaisedButton(
//                  onPressed: _jikeAction,
//                  child: Text('请求数据'),
//                ),
//                Text(showText)
//              ],
//            ),
//          ),
//        ),
//     );
//   }

//   void _jikeAction(){
//     print('开始请求数据');
//     getHttp().then((val){
//       setState(() {
//         showText = val['data'].toString();
//       });
//     });
//   }

//   Future getHttp() async{
//     try {
//       Response response;
//       Dio dio = new Dio();
//       dio.options.headers = httpHeaders;
//       response = await dio.get("https://time.geekbang.org/serv/v1/column/newAll");
//       print(response);
//       return response.data;
//     } catch (e) {
//       return print(e);
//     }
//   }
// }

//===========================实战课程==========================
class HomePage extends StatefulWidget {
  final Widget child;

  HomePage({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {   //页面保持
  String homePageContent = '正在获取数据';
  @override
  bool get wantKeepAlive => true;   //页面保持 

  @override
  void initState() {
    getHomePageContent().then((val) {
      setState(() {
        homePageContent = val.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('百姓生活+'),
        ),
        body: FutureBuilder(
          future: getHomePageContent(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //数据处理
              var data = json.decode(snapshot.data.toString());
              List<Map> swiper = (data['data']['slides'] as List).cast();
              List<Map> navigatorList =
                  (data['data']['category'] as List).cast();
              String adPicture =
                  data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String leaderImage = data['data']['shopInfo']['leaderImage'];
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];
              List<Map> recommendList = (data['data']['recommend'] as List).cast();

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SwiperDiy(swiperDataList: swiper),
                    TopNavigator(navigatorList: navigatorList),
                    AdBanner(adPicture: adPicture),
                    LeaderPhone(leaderImage: leaderImage, leaderPhone: leaderPhone),
                    Recommend(recommendList: recommendList)
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('加载中'),
              );
            }
          },
        ));
  }
}

//首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  // final Widget child;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('设备像素密度：${ScreenUtil.pixelRatio}');
    print('设备高度：${ScreenUtil.screenHeight}');
    print('设备宽度：${ScreenUtil.screenWidth}');

    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network("${swiperDataList[index]['image']}",
              fit: BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        Text('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }

    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

//=============广告条
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.network(adPicture),
      ),
    );
  }
}

//=====店长电话====
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchUrl,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchUrl() async {
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url不能打开，异常';
    }
  }
}

//=====商品列表-横向滑动
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

  //头部文本框
  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5,color: Colors.black12)
        )
      ),
      child: Text('商品推荐',style: TextStyle(color: Colors.pink)),
    );
  }
  //单一项商品 商品单独项
  Widget _itemWidget(index){
    return InkWell(
      onTap: (){},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5, color: Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text('￥${recommendList[index]['price']}',style: TextStyle(
              decoration:TextDecoration.lineThrough,
              color:Colors.grey 
            ),
            ),
          ],
        )
      ),
    ); 
  }
  //滑动窗口
  Widget _recommendList(){
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context,index){
          return _itemWidget(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(395),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList()

        ],
      ),
    );
  }
}


