import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue){
    isFavorite=newValue;
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    const url = 'https://flutter-update.firebaseio.com/products.json';
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final response = await http.patch(
        url, body: json.encode({
          'isFavorite': isFavorite
          }));
        if(response.statusCode >= 400){
          _setFavValue(oldStatus);
      notifyListeners();
        }
    } catch (error) {
      _setFavValue(oldStatus);
      notifyListeners();
    }
  }
}
