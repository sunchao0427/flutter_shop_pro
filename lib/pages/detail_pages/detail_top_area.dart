import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailInfoProvide>(
      builder: (context, child, val) {
        var goodsInfo =
            Provide.value<DetailInfoProvide>(context).goodsInfo.data.goodInfo;

        if (goodsInfo != null) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodsImage(goodsInfo.image1),
                _goodsName(goodsInfo.goodsName),
                _goodsNum(goodsInfo.goodsSerialNumber),
                _goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice)
              ],
            ),
          );
        } else {
          return Text('正在加载中.....');
        }
      },
    );
  }

  //商品图片
  Widget _goodsImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

  //商品名称
  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text(
        name,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30),
        ),
      ),
    );
  }

  //商品编号
  Widget _goodsNum(num) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text(
        '商品编号：$num',
        style: TextStyle(color: Colors.black26),
      ),
    );
  }

  //商品价格
  Widget _goodsPrice(realPrice, oriPrice) {
    return Container(
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      width: ScreenUtil().setWidth(740),
      child: Row(
        children: <Widget>[
          Text(
            '￥$realPrice',
            style:
                TextStyle(color: Colors.red, fontSize: ScreenUtil().setSp(40)),
          ),
          Text(
            '      市场价：',
            style: TextStyle(fontSize: ScreenUtil().setSp(26)),
          ),
          Text(
            ' ￥$oriPrice ',
            style: TextStyle(
                color: Colors.black12, decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
  }
}
