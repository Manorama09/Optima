import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Item with ChangeNotifier {
    String name;
    Item();

    Future<void> addItem(String token,String item) async {
    final url =
        'https://optima-55043.firebaseio.com/requestedItems.json?auth=$token';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          item,
        ),
      );
    } catch (error) {
      print(error);
    }
  }
}
