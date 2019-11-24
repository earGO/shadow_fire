import 'package:flutter/foundation.dart';

import './user.dart';

class Users with ChangeNotifier {
  List<User> _users = [
    User(
      name: 'Воевода Максим',
      id: DateTime.now().toString(),
      email: 'test1@gmail.com',
      visible: false,
    ),
    User(
      name: 'Орк Илья',
      id: DateTime.now().toString(),
      email: 'test2@gmail.com',
      visible: false,
    ),
    User(
      name: 'Таинственная бестия',
      id: DateTime.now().toString(),
      email: 'test3@gmail.com',
      visible: false,
    ),
    User(
      name: 'Стремительный хакер',
      id: DateTime.now().toString(),
      email: 'test4@gmail.com',
      visible: false,
    ),
    User(
      name: 'Ennglishman in new yourk',
      id: DateTime.now().toString(),
      email: 'test5@gmail.com',
      visible: false,
    ),
  ];

  List<User> get users {
    return [..._users];
  }

  List<User> findByName(String name) {
    return name == '' || name==null
        ?[..._users]
        : _users
            .where(
                (user) => user.name.toLowerCase().contains(name.toLowerCase()))
            .toList();
  }

  Future <void> fetchFilteredUsers(String filterString) async {

  }
}
