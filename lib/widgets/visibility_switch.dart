import 'package:flutter/material.dart';

class VisibilitySwitch extends StatelessWidget {
  final void switchHandler;
  final num iconDataNumber;
  final String title;
  final bool value;

  VisibilitySwitch(
      {this.title, this.value, this.switchHandler, this.iconDataNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 0,
      ),
      child: ListTile(
        leading: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            IconData(
              iconDataNumber,
              fontFamily: 'MaterialIcons',
            ),
            color: value ? Theme.of(context).secondaryHeaderColor : Theme.of(context).primaryColorLight,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
