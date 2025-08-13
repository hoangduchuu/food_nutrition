// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_analysis_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodAnalysisResult _$FoodAnalysisResultFromJson(Map<String, dynamic> json) =>
    FoodAnalysisResult(
      foodItems: (json['foodItems'] as List<dynamic>)
          .map((e) => FoodItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCalories: (json['totalCalories'] as num).toDouble(),
      totalProtein: (json['totalProtein'] as num).toDouble(),
      totalCarbs: (json['totalCarbs'] as num).toDouble(),
      totalFat: (json['totalFat'] as num).toDouble(),
      totalFiber: (json['totalFiber'] as num).toDouble(),
      totalSugar: (json['totalSugar'] as num).toDouble(),
      totalSodium: (json['totalSodium'] as num).toDouble(),
      analysisDate: json['analysisDate'] as String,
    );

Map<String, dynamic> _$FoodAnalysisResultToJson(FoodAnalysisResult instance) =>
    <String, dynamic>{
      'foodItems': instance.foodItems,
      'totalCalories': instance.totalCalories,
      'totalProtein': instance.totalProtein,
      'totalCarbs': instance.totalCarbs,
      'totalFat': instance.totalFat,
      'totalFiber': instance.totalFiber,
      'totalSugar': instance.totalSugar,
      'totalSodium': instance.totalSodium,
      'analysisDate': instance.analysisDate,
    };
