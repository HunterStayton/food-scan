import 'food_item.dart';

class CalorieData {
  static List<FoodItem> _foodItems = [];
  static int dailyGoal = 2000;

  static void addFood(FoodItem item) {
    _foodItems.add(item);
  }

  static List<FoodItem> getTodaysFoods() {
    final today = DateTime.now();
    return _foodItems.where((item) {
      return item.dateAdded.year == today.year &&
          item.dateAdded.month == today.month &&
          item.dateAdded.day == today.day;
    }).toList();
  }

  static int getTodaysCalories() {
    return getTodaysFoods().fold(0, (sum, item) => sum + item.calories);
  }

  static List<FoodItem> getAllFoods() {
    return List.from(_foodItems);
  }
}
