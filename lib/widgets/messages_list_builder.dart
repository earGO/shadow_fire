import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/messages.dart';
import '../widgets/messages_list_item.dart';

class MessagesListBuilder extends StatefulWidget {
  @override
  _MessagesListBuilderState createState() => _MessagesListBuilderState();
}

class _MessagesListBuilderState extends State<MessagesListBuilder> {
  @override
  Widget build(BuildContext context) {
    final messages = Provider.of<Messages>(context).currentMessages;
    return messages.length > 0
        ? ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Theme.of(context).primaryColorLight,
            ),
            itemCount: messages.length,
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: messages[index],
              child: MessagesListItem(),
            ),
          )
        : Center(
            child: Text(
              'Сообщений нет',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
  }
}
