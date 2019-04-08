import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/details_info.dart';

class DetailPage extends StatelessWidget {

  final String goodsId;
  DetailPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    _getGoodInfo(context);
    return Container(
      child: Center(
        child: Text('商品Id是： ${goodsId}'),
      ),    
    );
  }

  _getGoodInfo(BuildContext context)async{

    await Provide.value<DetailInfoProvide>(context).getGoodsInfo(goodsId);
    print('加载完成........');
  }
}