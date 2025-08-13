import 'dart:typed_data';
import '../../data/models/food_detection_result.dart';

abstract class FoodAnalysisRepository {
  Future<List<FoodDetectionResult>> analyzeFoodImage(Uint8List imageBytes);
}
