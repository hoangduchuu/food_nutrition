import 'package:json_annotation/json_annotation.dart';

part 'food_item.g.dart';

@JsonSerializable()
class FoodItem {
  final String name;
  final double portionGrams;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double fiber;
  final double sugar;
  final double sodium;

  FoodItem({
    required this.name,
    required this.portionGrams,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
    required this.sugar,
    required this.sodium,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) => _$FoodItemFromJson(json);
  Map<String, dynamic> toJson() => _$FoodItemToJson(this);

  FoodItem copyWith({
    String? name,
    double? portionGrams,
    double? calories,
    double? protein,
    double? carbs,
    double? fat,
    double? fiber,
    double? sugar,
    double? sodium,
  }) {
    return FoodItem(
      name: name ?? this.name,
      portionGrams: portionGrams ?? this.portionGrams,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      fiber: fiber ?? this.fiber,
      sugar: sugar ?? this.sugar,
      sodium: sodium ?? this.sodium,
    );
  }
}
