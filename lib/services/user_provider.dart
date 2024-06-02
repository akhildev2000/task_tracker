import 'package:flutter/material.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  List<User> users = [
    User(id: '1', username: 'manager', password: 'password', role: 'Manager'),
    User(
        id: '2',
        username: 'employee001',
        password: 'password',
        role: 'Employee'),
    User(
        id: '3',
        username: 'employee002',
        password: 'password',
        role: 'Employee'),
    User(
        id: '4',
        username: 'employee003',
        password: 'password',
        role: 'Employee'),
  ];

  List<String> get usernames => users.map((user) => user.username).toList();
}
