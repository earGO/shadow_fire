import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadowrun/providers/message.dart';
import 'package:shadowrun/providers/messages.dart';
import 'package:shadowrun/providers/users.dart';
import 'package:shadowrun/screens/main_screen.dart';

import '../connected/firebase_auth.dart';

class MessagesScreen extends StatefulWidget {
  static String routeName = '/messages-screen';

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  var _isInit = true;
  var _isLoading = false;
  String _token;
  String _userId;
  List<Message> _messages;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final uid = Provider.of<Users>(context).currentUser.getUser.uid;
    final token = Provider.of<AuthProvider>(context).token;
    if (_isInit) {
      setState(() {
        _isLoading = true;
        _token = token;
        _userId = uid;
      });
      Provider.of<Messages>(context, listen: false)
          .fetchAndSetMessages(userId: uid, token: token)
          .then((_) {
        if (this.mounted) {
          setState(() {
            _isLoading = false;
            _messages = Provider.of<Messages>(context).currentMessages;
          });
        }
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            const IconData(58820,
                fontFamily: 'MaterialIcons', matchTextDirection: true),
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
          },
        ),
        title: Text('Сообщения'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _messages.length > 0
              ? ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Theme.of(context).primaryColorLight,
                  ),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final item = _messages[index];

                    return Dismissible(
                      key: new Key(item.title),
                      direction: DismissDirection.horizontal,
                      onDismissed: (DismissDirection direction) async {
                        await Provider.of<Messages>(context, listen: false)
                            .dismissOneMessage(
                                token: _token,
                                userId: _userId,
                                messageId: item.messageId);
                        setState(() {
                          _messages.removeAt(index);
                        });
                      },
                      child: ListTile(
                        title: Text(
                          'Admin',
                          style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          item.body,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        leading: Icon(
                          IconData(59636, fontFamily: 'MaterialIcons'),
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'Сообщений нет',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
