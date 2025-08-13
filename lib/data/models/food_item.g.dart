// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodItem _$FoodItemFromJson(Map<String, dynamic> json) => FoodItem(
  name: json['name'] as String,
  portionGrams: (json['portionGrams'] as num).toDouble(),
  calories: (json['calories'] as num).toDouble(),
  protein: (json['protein'] as num).toDouble(),
  carbs: (json['carbs'] as num).toDouble(),
  fat: (json['fat'] as num).toDouble(),
  fiber: (json['fiber'] as num).toDouble(),
  sugar: (json['sugar'] as num).toDouble(),
  sodium: (json['sodium'] as num).toDouble(),
);

Map<String, dynamic> _$FoodItemToJson(FoodItem instance) => <String, dynamic>{
  'name': instance.name,
  'portionGrams': instance.portionGrams,
  'calories': instance.calories,
  'protein': instance.protein,
  'carbs': instance.carbs,
  'fat': instance.fat,
  'fiber': instance.fiber,
  'sugar': instance.sugar,
  'sodium': instance.sodium,
};
