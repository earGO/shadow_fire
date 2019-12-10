import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/users.dart';
import '../connected/firebase_auth.dart';

class SetCommunicate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final value=Provider.of<Users>(context).currentCommunicate;
    final token=Provider.of<AuthProvider>(context).token;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 0,
      ),
      child: ListTile(
        leading: Text(
          'Общения',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            IconData(
              value!=null && value ? 57546 : 57547,
              fontFamily: 'MaterialIcons',
            ),
            color: value!=null && value ? Theme.of(context).secondaryHeaderColor : Theme.of(context).primaryColorLight,
          ),
          onPressed: () {Provider.of<Users>(context,listen: false).toggleCurrentUserCommunicate(token: token);},
        ),
      ),
    );
  }
}
