// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;

// class Analytics with ChangeNotifier {
//   List<String> _items = [];
//   final String authToken;
//   final String userId;

//   Analytics(this.authToken, this.userId);

//   List<String> get itemList {
//     return [..._items];
//   }

//   Future<void> fetchAndSetOrders() async {
//     final url = 'https://optima-55043.firebaseio.com/analytics.json?auth=$authToken';
//     final response = await http.get(url);
//     final List<String> requiredItems = [];
//     final extractedData = json.decode(response.body) as Map<String, dynamic>;
//     if (extractedData == null) {
//       return;
//     }
//     extractedData.forEach((itemId, itemData) {
//       // requiredItems.add(
//       //   Item.name =itemData['name'].toString(),
//       // );
//     });
//     _items = requiredItems.reversed.toList();
//     notifyListeners();
//   }
// }