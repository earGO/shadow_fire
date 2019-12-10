import 'package:flutter/material.dart';

class GameRulesScreen extends StatelessWidget {
  static String routeName='/game-rules';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Правила игры'),
      ),
      body: Center(
        child: Text('Правила игры'),
      ),
    );
  }
}
