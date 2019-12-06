import 'dart:convert';

import 'package:flutter/foundation.dart';

class Message with ChangeNotifier {
  String body;
  String title;
  String messageId;

  Message({this.body, this.title,this.messageId});

  Message get message {
    return this;
  }

  factory Message.fromJson(Map<String, dynamic> parsedJson) {
    return Message(
      body: parsedJson['body'],
      title: parsedJson['title'],
        messageId:parsedJson['messageId']
    );
  }
}
