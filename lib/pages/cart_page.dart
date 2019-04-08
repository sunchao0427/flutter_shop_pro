import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';


class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text('购物车'),),
      body: Center(
        child: Column(
         children: <Widget>[
           myNumber(),
           myButton()
         ],
        ),
      ),
    );
  }
}

class myNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 200),
      child: Provide<Counter>(
        builder: (context,child,val){
          return Text(
            '${val.value}',
            style: Theme.of(context).textTheme.display1,
          );
        },
      ),
    );
  }
}

class myButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: (){
          Provide.value<Counter>(context).increment();
        },
        child: Text('递增'),
      ),
      
    );
  }
}