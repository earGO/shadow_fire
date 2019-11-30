import 'package:flutter/material.dart';

class UserNameScreen extends StatelessWidget {
  static String routeName = '/userName';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль бегущего'),
      ),
      body: Center(
        child: Text('Профиль'),
      ),
    );
  }
}
