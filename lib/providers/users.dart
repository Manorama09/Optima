import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import './user.dart';

class Users with ChangeNotifier {
  List<User> _users = [];
  
  final String authToken;
  final String userId;

  Users(this.authToken, this.userId, this._users);

   List<User> get users {
    return [..._users];
  }

  User findById(String id) {
    return _users.firstWhere((user) => user.id == id);
  }

  //   Future<void> fetchAndSetUsers([bool filterByUser = false]) async {
  //   final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
  //   var url =
  //       'https://optima-55043.firebaseio.com/users.json?auth=$authToken&$filterString';
  //   try {
  //     final response = await http.get(url);
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     if (extractedData == null) {
  //       return;
  //     }
  //     final List<User> loadedUsers = [];
  //     extractedData.forEach((userxId, userData) {
  //       loadedUsers.add(User(
  //         id: userxId,
  //         email: userData['email'],
  //         userType: userData['userType'],
  //       ));
  //     });
  //     _users = loadedUsers;
  //     notifyListeners();
  //   } catch (error) {
  //     throw (error);
  //   }
  // }

  Future<void> addUser(User user) async {
    final url =
        'https://optima-55043.firebaseio.com/users.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'id': user.id,
          'email': user.email,
          'type': user.userType,
        }),
      );
      final newUser = User(
        id: user.id,
        email: user.email,
        userType: user.userType,
       // id: json.decode(response.body)['name'],
      );
      _users.add(newUser);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
 
}
