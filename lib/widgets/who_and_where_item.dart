import 'package:flutter/material.dart';
import '../providers/user.dart';

class WhoAndWhereItem extends StatelessWidget {
  User user;

  WhoAndWhereItem(this.user);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: user.avatar != null
          ? CircleAvatar(
              child: Image.network(user.avatar),
            )
          : CircleAvatar(child: Icon(Icons.account_circle)),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 30,
        child: Row(
          children: <Widget>[
            if (user.wantToBeHammered)
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
