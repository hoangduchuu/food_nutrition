// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_detection_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodDetectionResult _$FoodDetectionResultFromJson(Map<String, dynamic> json) =>
    FoodDetectionResult(
      name: json['name'] as String,
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
    );

Map<String, dynamic> _$FoodDetectionResultToJson(
  FoodDetectionResult instance,
) => <String, dynamic>{
  'name': instance.name,
  'calories': instance.calories,
  'protein': instance.protein,
  'carbs': instance.carbs,
  'fat': instance.fat,
};
