import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainScreenSmallIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 88,
        height: 88,
        margin: EdgeInsets.all(4),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Icon(
            MdiIcons.creditCard,
            size: 55,
          ),
        ),
      ),
    );
  }
}
