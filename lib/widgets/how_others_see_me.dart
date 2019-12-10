import 'package:flutter/material.dart';
import '../providers/user.dart';

class HowOthersSeeMe extends StatelessWidget {
  User user;
  bool currentHammered;

  HowOthersSeeMe({this.user,this.currentHammered});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: user.avatar != null
          ? CircleAvatar(
        child: Image.network(user.avatar),
      )
          : CircleAvatar(child: Icon(Icons.account_circle)),
      title: Text('${user.status} ${user.name}'),
      subtitle: Text(user.lastCheckIn),
      trailing: Container(
        width: 30,
        child: Row(
          children: <Widget>[
            if (currentHammered)
              Icon(
                IconData(59406, fontFamily: 'MaterialIcons'),
                color: Theme.of(context).secondaryHeaderColor,
              )
          ],
        ),
      ),
    );
  }
}
