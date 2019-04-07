import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {

  final String goodsId;
  DetailPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('商品Id是： ${goodsId}'),
      ),    
    );
  }
}