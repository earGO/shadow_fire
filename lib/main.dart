import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './ui/home.dart';
import './ui/login.dart';
import './ui/splash.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shadowrun/providers/users.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static final Map<int, Color> primaryColor = {
    50: Color.fromRGBO(55, 71, 79, .1),
    100: Color.fromRGBO(55, 71, 79, .2),
    200: Color.fromRGBO(55, 71, 79, .3),
    300: Color.fromRGBO(55, 71, 79, .4),
    400: Color.fromRGBO(55, 71, 79, .5),
    500: Color.fromRGBO(55, 71, 79, .6),
    600: Color.fromRGBO(55, 71, 79, .7),
    700: Color.fromRGBO(55, 71, 79, .8),
    800: Color.fromRGBO(155, 71, 79, .9),
    900: Color.fromRGBO(55, 71, 79, 1),
  };

  static final MaterialColor primaryColorCustom = MaterialColor(0xff37474f, primaryColor);

  static final Map<int, Color> secondaryColor = {
    50: Color.fromRGBO(2, 119, 189, .1),
    100: Color.fromRGBO(2, 119, 189, .2),
    200: Color.fromRGBO(2, 119, 189, .3),
    300: Color.fromRGBO(2, 119, 189, .4),
    400: Color.fromRGBO(2, 119, 189, .5),
    500: Color.fromRGBO(2, 119, 189, .6),
    600: Color.fromRGBO(2, 119, 189, .7),
    700: Color.fromRGBO(2, 119, 189, .8),
    800: Color.fromRGBO(2, 119, 189, .9),
    900: Color.fromRGBO(2, 119, 189, 1),
  };

  static final MaterialColor secondaryColorCustom = MaterialColor(0xff0277bd, secondaryColor);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShadowRun 2020',
      theme: ThemeData(
        primarySwatch: primaryColorCustom,
        secondaryHeaderColor:secondaryColorCustom,
      ),
      home: MainScreen(),
    );
  }
}


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context,AsyncSnapshot<FirebaseUser> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
          return SplashPage();
        if(!snapshot.hasData || snapshot.data == null)
          return LoginPage();
        return HomePage();
      },
    );
  }
}
