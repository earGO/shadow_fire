import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowrun/screens/game_rules_screen.dart';
import 'package:shadowrun/screens/login_screen.dart';
import 'package:shadowrun/screens/name_screen.dart';
import '../providers/users.dart';
import '../connected/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<Users>(context).currentUser;
    final token = Provider.of<AuthProvider>(context).token;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      transform: Matrix4.translationValues(-24.0, 0.0, 0.0),
                      decoration: BoxDecoration(),
                      child: ListTile(
                          leading: currentUser.avatar != null
                              ? CircleAvatar(
                                  radius: 32.0,
                                  child: Image.network(currentUser.avatar))
                              : CircleAvatar(
                                  radius: 32.0,
                                  child: Icon(Icons.account_circle),
                                )),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 4),
                      child: Text(
                        currentUser.email,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Имя в игре'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).pushNamed(NameScreen.routeName);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.mood),
              title: Text('Правила'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).pushNamed(GameRulesScreen.routeName);
              },
            ),
            Divider(),
            SizedBox(
              height: 64,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Выход'),
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).logOut();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
