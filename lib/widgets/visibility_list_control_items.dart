import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';
import '../providers/users.dart';
import '../connected/firebase_auth.dart';

class VisibilityListControlItems extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final name = Provider.of<User>(context).name;
    final avatar = Provider.of<User>(context).avatar;
    final currentUser = Provider.of<Users>(context).currentUser;
    final token=Provider.of<AuthProvider>(context).token;
    return ListTile(
        leading: avatar != null
            ? CircleAvatar(
          child: Image.network(avatar),
        )
            : CircleAvatar(child: Icon(Icons.account_circle)),
        title: Text(name),
      trailing: Consumer<User>(
        builder: (ctx, user, _) => IconButton(
          icon: Icon(
            user.visible ?
            Icons.check_box
                : Icons.check_box_outline_blank ,
          ),
          color: Theme.of(context).secondaryHeaderColor,
          onPressed: () {
            user.toggleFavoriteStatus(
              token: token,
              ownerId: currentUser.uid,
              arrayId: user.uid,
            );
          },
        ),
      ),

    );
  }
}
