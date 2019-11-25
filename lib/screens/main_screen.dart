import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowrun/providers/users.dart';
import 'package:shadowrun/widgets/main_screen_small_icon.dart';
import 'package:shadowrun/widgets/play_button.dart';
import '../connected/firebase_auth.dart';

class MainScreen extends StatelessWidget {
  static String routeName = '/main';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 84),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 40, left: 106),
                padding: EdgeInsets.only(right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    if (user != null)
                      Text(
                        'Shadowrunner ${user.name.split(' ')[0]}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    if (user != null)
                      Text('\$ ${user.credits}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      )
                  ],
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('Main screen'),
                    if (user != null) Text('Hello, ${user.name}'),
                    RaisedButton(
                      child: Text("Log out"),
                      onPressed: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .logOut();
                      },
                    ),
                    Container(
                      height: 280,
                      padding: EdgeInsets.only(bottom: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              MainScreenSmallIcon(
                                iconCode: 59504,
                              ),
                              MainScreenSmallIcon(
                                iconCode: 58146,
                              ),
                              MainScreenSmallIcon(
                                iconCode: 57534,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              MainScreenSmallIcon(
                                iconCode: 59603,
                              ),
                              MainScreenSmallIcon(
                                iconCode: 59389,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    PlayButton(),
                  ],
                ),
              ),
            ]),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
