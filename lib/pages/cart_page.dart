import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text('购物车'),),
      body: Center(
        child: Text('购物车界面'),
      ),
    );
  }
}