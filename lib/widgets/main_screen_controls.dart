import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowrun/screens/installed_implants.dart';
import 'package:shadowrun/screens/messages_screen.dart';
import 'package:shadowrun/screens/profile_screen.dart';
import 'package:shadowrun/screens/shop_screen.dart';

import 'package:shadowrun/widgets/main_screen_small_icon.dart';
import 'package:shadowrun/widgets/play_button.dart';
import 'package:shadowrun/providers/users.dart';
import 'package:shadowrun/providers/messages.dart';

import 'package:shadowrun/screens/social_screen.dart';

class MainScreenControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context).currentUser;
    final credits = Provider.of<Users>(context).currentCredits;
    final name = Provider.of<Users>(context).currentName;
    final messages = Provider.of<Users>(context).currentMessages;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(bottom: 84),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: screenHeight * 0.05),
              padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  if (user != null)
                    Text(
                      'Shadowrunner ${name.split(' ')[0]}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  if (user != null)
                    Container(
                      margin: EdgeInsets.only(left: screenWidth * 0.05),
                      child: Text(
                        '\$ ${credits.toString()}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: screenHeight * 0.45,
                    width: screenWidth * 0.95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MainScreenSmallIcon(
                              iconCode: 59504,
                              routeName: Shop.routeName,
                            ),
                            MainScreenSmallIcon(
                              iconCode: 58146,
                              routeName: InstalledImplants.routeName,
                            ),
                            Stack(children: <Widget>[
                              MainScreenSmallIcon(
                                iconCode: 57534,
                                routeName: MessagesScreen.routeName,
                              ),
                              messages.length > 0
                                  ? Positioned(
                                      right: 8,
                                      top: 8,
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Theme.of(context)
                                            .secondaryHeaderColor,
                                      ),
                                    )
                                  : Container(),
                            ]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MainScreenSmallIcon(
                              iconCode: 59603,
                              routeName: SocialScreen.routeName,
                            ),
                            MainScreenSmallIcon(
                              iconCode: 59389,
                              routeName: ProfileScreen.routeName,
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
    );
  }
}
