import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import './message.dart';

class Messages with ChangeNotifier {
  List<Message> _curentMessages;

  List<Message> get currentMessages {
    return [..._curentMessages];
  }

  List<Message> _setCurrentMessages(List<Message> messages) {
    _curentMessages = messages;
    notifyListeners();
  }

  Future<void> fetchAndSetMessages({String token, String userId}) async {
    final url =
        'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/getAllMessages';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'userId': userId,
          },
        ),
        headers: {'Authorization': "Bearer $token"},
      );
      final decoded = await json.decode(response.body) as Map<String, dynamic>;
      final messagesData = decoded['messages'];
      if (messagesData == null) {
        return;
      }
      print(messagesData);
      final List<Message> intermediate = [];
      messagesData.forEach((item) {
        intermediate.add(Message.fromJson(item));
      });
      _curentMessages = intermediate;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> dismissOneMessage(
      {String token, String userId, String messageId}) async {
    final oldMessages = _curentMessages;
    final url =
        'https://us-central1-shadowrun-mobile.cloudfunctions.net/api/dismissOneMessage';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'userId': userId,
            'messageId': messageId,
          },
        ),
        headers: {'Authorization': "Bearer $token"},
      );
      final decoded = await json.decode(response.body) as Map<String, dynamic>;
      final messagesData = decoded['messages'];
      final message = decoded['message'];
      if (messagesData == null) {
        _setCurrentMessages(oldMessages);
        return;
      }
      if (message != 'good') {
        _setCurrentMessages(oldMessages);
        return;
      }
      final List<Message> intermediate = [];
      messagesData.forEach((item) {
        intermediate.add(Message.fromJson(item));
      });
      _setCurrentMessages(intermediate);
    } catch (error) {
      _setCurrentMessages(oldMessages);
    }
  }
}
