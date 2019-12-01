import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainScreenSmallIcon extends StatelessWidget {
  int iconCode;
  String routeName;

  MainScreenSmallIcon({this.iconCode,this.routeName});

  @override
  Widget build(BuildContext context) {
    final  screenWidth = MediaQuery.of(context).size.width;
    final  screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth*0.021,vertical: screenHeight*0.017),
      child: Card(
        child: Container(
          width: screenWidth*0.25,
          height: screenWidth*0.25,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.of(context).pushNamed(routeName);
            },
            child: Icon(
              IconData(iconCode, fontFamily: 'MaterialIcons'),
              size: screenWidth*0.185,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
