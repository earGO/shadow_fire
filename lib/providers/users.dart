import 'package:flutter/foundation.dart';

import './user.dart';

class Users with ChangeNotifier {
  List<User> _users = [];

  List<User> get users {
    return [..._users];
  }

  List<User> findByName(String name) {
    return name == '' || name == null
        ? [..._users]
        : _users
            .where(
                (user) => user.name.toLowerCase().contains(name.toLowerCase()))
            .toList();
  }


  Future<void> fetchFilteredUsers(String filterString) async {}
}
