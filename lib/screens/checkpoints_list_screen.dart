import 'package:flutter/material.dart';

class CheckpointsListScreen extends StatelessWidget {
  static String routeName = '/checkpoints-list';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Чек пойнты'),
      ),
    );
  }
}
