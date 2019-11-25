import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainScreenSmallIcon extends StatelessWidget {
  int iconCode;
  String routeName;

  MainScreenSmallIcon({this.iconCode,this.routeName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        child: Container(
          width: 96,
          height: 96,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.of(context).pushNamed(routeName);
            },
            child: Icon(
              IconData(iconCode, fontFamily: 'MaterialIcons'),
              size: 65,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
