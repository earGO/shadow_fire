import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';
import '../providers/users.dart';
import '../connected/firebase_auth.dart';

class VisibilityListControlItemShowAll extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final currentVisibleToAll = Provider.of<Users>(context).currentVisibleToAll;
    final token=Provider.of<AuthProvider>(context).token;
    return ListTile(
        leading: CircleAvatar(child: Icon(IconData(59603))),
        title: Text('Сделать видимым для всех'),
      trailing: IconButton(
          icon: Icon(
            currentVisibleToAll ?
            Icons.check_box
                : Icons.check_box_outline_blank ,
          ),
          color: Theme.of(context).secondaryHeaderColor,
          onPressed: () {
            Provider.of<Users>(context,listen: false).toggleCurrentUserVisibleToAll(
              token: token,
            );
          },
        ),

    );
  }
}
