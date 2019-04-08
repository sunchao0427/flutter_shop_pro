import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../pages/details_page.dart';
//此文件为书写Handler文件 每个路由页面都有自己的Handler 主要定义参数信息 创建page页面与方法Handler的联系。
Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params){
    String goodsId = params['id'].first;
    print('details page id is >> ${goodsId}');
    return DetailPage(goodsId);
  }
);