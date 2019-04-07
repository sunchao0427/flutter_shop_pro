import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './details_router.dart';

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