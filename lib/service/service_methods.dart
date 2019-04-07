import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

//抽取共有方法
Future request(url, {formData}) async {
  try {
    print('开始获取共有数据');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    // var formData = {'lon': '115.02932', 'lat': '35.76189'};
    if (formData ==null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url],data:formData);
    }

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口不正常，异常！');
    }
  } catch (e) {
    return print('ERROR:=====>$e');
  }
}

//获取主页主题内容
Future getHomePageContent() async {
  try {
    print('获取首页数据');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    response = await dio.post(servicePath['homePageContent'], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口不正常，异常！');
    }
  } catch (e) {
    return print('ERROR:=====>$e');
  }
}

//获取火爆专区内容
Future getHomePageBelowContent() async {

  try {
    print('获取火爆专区数据');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
        int page = 1;
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    response = await dio.post(servicePath['homePageBelowContent'], data: page);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口不正常，异常！');
    }
  } catch (e) {
    return print('ERROR:=====>$e');
  }
}
