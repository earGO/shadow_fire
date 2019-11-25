import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowrun/providers/users.dart';
import '../connected/firebase_auth.dart';

class MainScreen extends StatelessWidget {
  static String routeName = '/main';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Main screen'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Main screen'),
            if (user != null) Text('Hello, ${user.name}'),
            RaisedButton(
              child: Text("Log out"),
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logOut();
              },
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
