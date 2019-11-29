import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = '/profile';
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
