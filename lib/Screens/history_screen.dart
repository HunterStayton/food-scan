import 'package:flutter/material.dart';

import '../models/calorie_data.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final allFoods = CalorieData.getAllFoods();
    return Scaffold(
      body: allFoods.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No history yet',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: allFoods.length,
        itemBuilder: (context, index) {
          final food = allFoods.reversed.toList()[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _getCategoryColor(food.category),
                child: Text(
                  food.category[0].toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(food.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(food.category),
                  Text(
                    '${food.dateAdded.day}/${food.dateAdded.month}/${food.dateAdded.year} at ${food.dateAdded.hour}:${food.dateAdded.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              trailing: Text(
                '${food.calories} cal',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'breakfast':
        return Colors.orange;
      case 'lunch':
        return Colors.blue;
      case 'dinner':
        return Colors.purple;
      case 'snacks':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}