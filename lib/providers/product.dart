import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app_max_flutter/model/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isFavorite=false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  void toggleFavoriteStatus() async {
    final oldStateFavorite = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = "https://shop-flutter-9764c.firebaseio.com/products/$id.json";
    try {
      final response = await http.patch(
          url, body: json.encode({'isFavorite': isFavorite}));
      if (response.statusCode >= 400) {
        _setFavValue(oldStateFavorite);
      }
    } catch (error) {
      print(error);
      _setFavValue(oldStateFavorite);
    }
  }
}
