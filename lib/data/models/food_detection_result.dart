import 'package:json_annotation/json_annotation.dart';

part 'food_detection_result.g.dart';

@JsonSerializable()
class FoodDetectionResult {
  final String name;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;

  FoodDetectionResult({
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  factory FoodDetectionResult.fromJson(Map<String, dynamic> json) => 
      _$FoodDetectionResultFromJson(json);
  
  Map<String, dynamic> toJson() => _$FoodDetectionResultToJson(this);
}
