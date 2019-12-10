import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/message.dart';
import 'package:shadowrun/providers/messages.dart';
import 'package:shadowrun/providers/users.dart';

import 'package:shadowrun/connected/firebase_auth.dart';

class MessagesListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final message = Provider.of<Message>(context).message;
    final uid = Provider.of<Users>(context).currentUser.getUser.uid;
    final token = Provider.of<AuthProvider>(context).token;
    return Dismissible(
      key: new Key(message.title),
      direction: DismissDirection.horizontal,
      onDismissed: (DismissDirection direction) {
        Provider.of<Messages>(context,listen: false).dismissOneMessage(
          token: token,
          userId: uid,
          messageId: message.messageId
        );
        Provider.of<Messages>(context,listen: false).fetchAndSetMessages(
            token: token,
            userId: uid
        );
      },
      child: ListTile(
        title: Text('Admin',style: TextStyle(
          color: Theme.of(context).secondaryHeaderColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),),
        subtitle: Text(message.body,style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),),
        leading: Icon(
          IconData(59636, fontFamily: 'MaterialIcons'),
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
