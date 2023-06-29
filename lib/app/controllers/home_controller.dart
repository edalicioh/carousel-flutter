import 'dart:math';

import 'package:carousel/app/models/food_carousel.dart';

class HomeController {
  Random random = new Random();

  List<Map<String, String>> data = [
    {
      'img':
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=360&q=80',
      'title': 'Pizza food',
    },
    {
      'img':
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=360&q=80',
      'title': 'Chinese food',
    },
    {
      'img':
          'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=360&q=80',
      'title': 'Hamburger food',
    }
  ];

  List<FoodCarousel> load() {
    return data
        .map((e) => FoodCarousel(
            imageUrl: e['img'] as String,
            title: e['title'] as String,
            qtdComment: _generateInt(2000, 1000),
            rating: _generateDouble(5, 4),
            distance: _generateDouble(1, 3),
            time: _generateInt(90, 25)))
        .toList();
  }

  double _generateDouble(int max, int min) {
    final doubleRandom = min + (max - min) * random.nextDouble();
    return double.parse(doubleRandom.toStringAsFixed(1));
  }

  int _generateInt(int max, int min) {
    return min + random.nextInt(max - min);
  }
}
