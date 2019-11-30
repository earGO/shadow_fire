import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/users.dart';
import '../connected/firebase_auth.dart';

class SetHammered extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final value=Provider.of<Users>(context).currentHammered;
    final token=Provider.of<AuthProvider>(context).token;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 0,
      ),
      child: ListTile(
        leading: Text(
          'Огня',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            IconData(
              59406,
              fontFamily: 'MaterialIcons',
            ),
            color: value ? Theme.of(context).secondaryHeaderColor : Theme.of(context).primaryColorLight,
          ),
          onPressed: () {Provider.of<Users>(context,listen: false).toggleCurrentUserHammered(token: token);},
        ),
      ),
    );
  }
}
