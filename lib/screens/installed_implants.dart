import 'package:flutter/material.dart';

class InstalledImplants extends StatelessWidget {
  static String routeName = '/installed-implants';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Импланты'),
      ),
      body: Center(
        child: Text('Installed Implants screen'),
      ),
    );
  }
}
