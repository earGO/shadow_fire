import 'package:flutter/material.dart';

class VisibilitySwitch extends StatelessWidget {
  final Function switchHandler;
  final String title;
  final bool value;

  VisibilitySwitch({this.title, this.value, this.switchHandler});

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
        trailing: Switch.adaptive(
          activeColor: Theme.of(context).secondaryHeaderColor,
          value: value,
          onChanged: switchHandler,
        ),
      ),
    );
  }
}
