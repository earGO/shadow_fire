import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  static String routeName = '/messages-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сообщения'),
      ),
      body: Center(
        child: Text('Нет сообщений',style: TextStyle(
          color: Colors.white,
        ),),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
