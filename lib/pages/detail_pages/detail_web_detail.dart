import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailWebDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodDetail = Provide.value<DetailInfoProvide>(context).goodsInfo.data.goodInfo.goodsDetail;

    return Provide<DetailInfoProvide>(
      builder: (context,child,val){
        bool isLeft = Provide.value<DetailInfoProvide>(context).isLeft;


        if (isLeft) {
          return Container(
            child: Html(
              data: goodDetail,
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            width: ScreenUtil().setWidth(750),
            child: Text('暂时没有数据'),
          );
        }
      },
    );
  }



}
