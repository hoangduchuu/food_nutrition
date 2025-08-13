import 'package:json_annotation/json_annotation.dart';
import 'food_item.dart';

part 'food_analysis_result.g.dart';

@JsonSerializable()
class FoodAnalysisResult {
  final List<FoodItem> foodItems;
  final double totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFat;
  final double totalFiber;
  final double totalSugar;
  final double totalSodium;
  final String analysisDate;

  FoodAnalysisResult({
    required this.foodItems,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFat,
    required this.totalFiber,
    required this.totalSugar,
    required this.totalSodium,
    required this.analysisDate,
  });

  factory FoodAnalysisResult.fromJson(Map<String, dynamic> json) => 
      _$FoodAnalysisResultFromJson(json);
  
  Map<String, dynamic> toJson() => _$FoodAnalysisResultToJson(this);

  FoodAnalysisResult copyWith({
    List<FoodItem>? foodItems,
    double? totalCalories,
    double? totalProtein,
    double? totalCarbs,
    double? totalFat,
    double? totalFiber,
    double? totalSugar,
    double? totalSodium,
    String? analysisDate,
  }) {
    return FoodAnalysisResult(
      foodItems: foodItems ?? this.foodItems,
      totalCalories: totalCalories ?? this.totalCalories,
      totalProtein: totalProtein ?? this.totalProtein,
      totalCarbs: totalCarbs ?? this.totalCarbs,
      totalFat: totalFat ?? this.totalFat,
      totalFiber: totalFiber ?? this.totalFiber,
      totalSugar: totalSugar ?? this.totalSugar,
      totalSodium: totalSodium ?? this.totalSodium,
      analysisDate: analysisDate ?? this.analysisDate,
    );
  }
}
