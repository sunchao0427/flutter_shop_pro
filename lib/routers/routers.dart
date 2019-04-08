import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './details_router.dart';

/* *
 * 
 * 此文件为路由的总体配置文件 使用写好的Handler文件内的方法  创建全局静态化的Route 与handler的联系  参数包含：
 * notFoundHandler 没有Handler时候的处理； 
 * define为正常的路由处理
 *  
 * */
class Routes{
  static String root = '/';
  static String detailsPage = '/detail';
  
  static void configureRoutes(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('ERROR ======>');
      }
    );
    
    router.define(detailsPage, handler: detailsHandler);
  }

}