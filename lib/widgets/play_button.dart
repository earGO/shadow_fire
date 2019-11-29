import 'package:flutter/material.dart';
import 'package:shadowrun/screens/checkpoints_list_screen.dart';

class PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Card(
        child: Container(
          width: 328,
          height: 88,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.of(context).pushNamed(CheckpointsListScreen.routeName);
            },
            child: Icon(
              IconData(57399, fontFamily: 'MaterialIcons'),
              size: 95,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
