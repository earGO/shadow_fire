import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';

class VisibilityListControlItems extends StatelessWidget {
//  final String name;
//  final String photoUrl;
//  final String uid;
//
//  VisibilityListControlItems({this.name, this.uid, this.photoUrl});

  @override
  Widget build(BuildContext context) {
    final name = Provider.of<User>(context).name;
    final avatar = Provider.of<User>(context).avatar;
    return ListTile(
        leading: avatar != null
            ? CircleAvatar(
          child: Image.network(avatar),
        )
            : CircleAvatar(child: Icon(Icons.account_circle)),
        title: Text(name),

    );
  }
}
