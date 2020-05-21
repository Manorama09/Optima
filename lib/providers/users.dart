// import 'dart:convert';
// import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;
// import './user.dart';

// class Users with ChangeNotifier {
//   List<User> _users = [];
  
//   final String authToken;
//   final String userId;

//   Users(this.authToken, this.userId, this._users);

//    List<User> get users {
//     return [..._users];
//   }

//   User findById(String id) {
//     return _users.firstWhere((user) => user.userId == id);
//   }

//   Future<void> addUser(User user) async {
//     final url =
//         'https://optima-55043.firebaseio.com/users.json?auth=$authToken';
//     try {
//       final response = await http.post(
//         url,
//         body: json.encode({
//           'id': user.userId,
//           'email': user.email,
//           'seller': user.seller,
//         }),
//       );

//       final newUser = User(
//         userId: user.userId,
//         email: user.email,
//         seller: user.seller,
//       );
//       _users.add(newUser);

//       notifyListeners();
//     } catch (error) {
//       print(error);
//       throw error;
//     }
//   }
// }
