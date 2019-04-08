import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailExplainArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(top: 8.0),
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      child: Text(
        '说明：> 急速送达 > 正品保证',
        style: TextStyle(
          color: Color.fromRGBO(245, 23, 20, 1.0),
          fontSize: ScreenUtil().setSp(30)
        ),
      ),
      
    );
  }
}