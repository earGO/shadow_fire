import 'package:flutter/material.dart';

class Shop extends StatelessWidget {
  static String routeName='/implants-shop';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Магазин имплантов'),
      ),
      body: Center(
        child: Text('Магазин имплантов'),
      ),
    );
  }
}
