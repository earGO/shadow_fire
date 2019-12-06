
import 'package:flutter/material.dart';
import 'package:shadowrun/providers/implants.dart';
import 'package:shadowrun/screens/check_in_screen.dart';
import 'package:shadowrun/screens/checkpoints_list_screen.dart';
import 'package:shadowrun/screens/game_rules_screen.dart';
import 'package:shadowrun/screens/installed_implants.dart';
import 'package:shadowrun/screens/main_screen.dart';
import 'package:shadowrun/screens/messages_screen.dart';
import 'package:shadowrun/screens/name_screen.dart';
import 'package:shadowrun/screens/profile_screen.dart';
import 'package:shadowrun/screens/shop_screen.dart';
import 'package:shadowrun/screens/social_screen.dart';
import 'package:shadowrun/screens/user_name_screen.dart';
import 'package:shadowrun/screens/visibility_control_screen.dart';
import './screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shadowrun/providers/users.dart';
import 'package:shadowrun/providers/locations.dart';
import 'connected/firebase_auth.dart';

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

  static final MaterialColor primaryColorCustom =
      MaterialColor(0xff37474f, primaryColor);

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

  static final MaterialColor secondaryColorCustom =
      MaterialColor(0xff0277bd, secondaryColor);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Users(),
        ),
        ChangeNotifierProvider.value(
          value: Locations(),
        ),
        ChangeNotifierProvider.value(
          value: Implants(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'ShadowRun 2020',
          theme: ThemeData(
            primarySwatch: primaryColorCustom,
            secondaryHeaderColor: secondaryColorCustom,
          ),
          home: auth.isAuth
              ? MainScreen()
              :  LoginPage(),
          routes: {
            MainScreen.routeName: (ctx) => MainScreen(),
            SocialScreen.routeName: (ctx) => SocialScreen(),
            InstalledImplants.routeName: (ctx) => InstalledImplants(),
            Shop.routeName: (ctx) => Shop(),
            ProfileScreen.routeName: (ctx) => ProfileScreen(),
            MessagesScreen.routeName: (ctx) => MessagesScreen(),
            CheckpointsListScreen.routeName: (ctx) => CheckpointsListScreen(),
            VisibilityControlScreen.routeName: (ctx) =>
                VisibilityControlScreen(),
            UserNameScreen.routeName: (ctx) => UserNameScreen(),
            LoginPage.routeName: (ctx) => LoginPage(),
            NameScreen.routeName: (ctx) => NameScreen(),
            GameRulesScreen.routeName: (ctx) => GameRulesScreen(),
            CheckpointsListScreen.routeName: (ctx) => CheckpointsListScreen(),
            CheckInScreen.routeName: (ctx) => CheckInScreen(),
          },
        ),
      ),
    );
  }
}
