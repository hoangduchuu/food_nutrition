import 'package:flutter/material.dart';
import '../../../data/models/nutrition_summary.dart';

class NutritionSummaryWidget extends StatelessWidget {
  final NutritionSummary summary;

  const NutritionSummaryWidget({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nutrition Summary',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text('Total Items: ${summary.itemCount}'),
        Text('Protein: ${summary.totalProtein.round()}g'),
        Text('Carbs: ${summary.totalCarbs.round()}g'),
        Text('Fat: ${summary.totalFat.round()}g'),
        Text('Total: ${summary.totalCalories.round()} kcal', style: TextStyle(fontWeight: FontWeight.bold),),
      ],
    );
  }
}
