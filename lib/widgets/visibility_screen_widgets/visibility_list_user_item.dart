import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user.dart';

class VisibilityListUserItem extends StatelessWidget {
  final user;
//
  VisibilityListUserItem(this.user);

  @override
  Widget build(BuildContext context) {

    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Checkbox(
        value: user.visible,
        onChanged: null,
        activeColor: Theme.of(context).secondaryHeaderColor,
      ),
    );
  }
}
