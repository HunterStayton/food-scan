import 'dart:core';

class FoodItem {
  final String name;
  final int calories;
  final String category;
  final DateTime dateAdded;
  final int carbs;
  final int fat;
  final int protein;

  FoodItem({
    required this.carbs,
    required this.fat,
    required this.protein,
    required this.name,
    required this.calories,
    required this.category,
    required this.dateAdded,
  });
}
