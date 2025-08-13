import 'dart:async';
import '../models/food_item.dart';
import '../models/food_analysis_result.dart';

class MockFoodAnalysisService {
  // Simulate API delay
  Future<FoodAnalysisResult> analyzeFoodImage(String imagePath) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Return mock data based on the image path or random data
    return _generateMockAnalysisResult();
  }

  FoodAnalysisResult _generateMockAnalysisResult() {
    // Create realistic mock food items
    final foodItems = [
      FoodItem(
        name: 'Grilled Chicken Breast',
        portionGrams: 150.0,
        calories: 165.0,
        protein: 31.0,
        carbs: 0.0,
        fat: 3.6,
        fiber: 0.0,
        sugar: 0.0,
        sodium: 74.0,
      ),
      FoodItem(
        name: 'Brown Rice',
        portionGrams: 100.0,
        calories: 111.0,
        protein: 2.6,
        carbs: 23.0,
        fat: 0.9,
        fiber: 1.8,
        sugar: 0.4,
        sodium: 5.0,
      ),
      FoodItem(
        name: 'Broccoli',
        portionGrams: 80.0,
        calories: 27.0,
        protein: 2.8,
        carbs: 5.2,
        fat: 0.3,
        fiber: 2.6,
        sugar: 1.1,
        sodium: 33.0,
      ),
      FoodItem(
        name: 'Olive Oil',
        portionGrams: 15.0,
        calories: 119.0,
        protein: 0.0,
        carbs: 0.0,
        fat: 13.5,
        fiber: 0.0,
        sugar: 0.0,
        sodium: 0.0,
      ),
    ];

    // Calculate totals
    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;
    double totalFiber = 0;
    double totalSugar = 0;
    double totalSodium = 0;

    for (var item in foodItems) {
      totalCalories += item.calories;
      totalProtein += item.protein;
      totalCarbs += item.carbs;
      totalFat += item.fat;
      totalFiber += item.fiber;
      totalSugar += item.sugar;
      totalSodium += item.sodium;
    }

    return FoodAnalysisResult(
      foodItems: foodItems,
      totalCalories: totalCalories,
      totalProtein: totalProtein,
      totalCarbs: totalCarbs,
      totalFat: totalFat,
      totalFiber: totalFiber,
      totalSugar: totalSugar,
      totalSodium: totalSodium,
      analysisDate: DateTime.now().toIso8601String(),
    );
  }
}
