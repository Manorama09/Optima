import 'package:flutter/material.dart';

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Goodlife Milk',
      description: 'A dairy product',
      price: 22,
      imageUrl:
          'https://www.biggro.com/content/images/thumbs/0015514_good-life-cow-milk-brick-500-ml_550.jpeg',
    ),
    Product(
      id: 'p2',
      title: 'Basmati Rice',
      description: 'Staple food',
      price: 300,
      imageUrl:
          'https://images-na.ssl-images-amazon.com/images/I/61yIOKgKbfL._SX425_.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Ashirvaad Atta',
      description: 'Staple food',
      price: 450,
      imageUrl:
          'https://d37ky63zmmmzfj.cloudfront.net/production/itemimages/grocery/flours_sooji/wheat_atta/itc_food_aashir_atta_5kg.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Lays',
      description: 'All time snack',
      price: 20,
      imageUrl:
          'https://images-na.ssl-images-amazon.com/images/I/81vJyb43URL._SX425_PIbundle-40,TopRight,0,0_AA425SH20_.jpg',
    ),
  ];
  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}
