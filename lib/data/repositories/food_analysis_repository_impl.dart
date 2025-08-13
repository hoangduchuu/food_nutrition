import 'dart:typed_data';
import '../../domain/repositories/food_analysis_repository.dart';
import '../models/food_detection_result.dart';
import '../services/openai_food_analysis_service.dart';

class FoodAnalysisRepositoryImpl implements FoodAnalysisRepository {
  final OpenAIFoodAnalysisService _analysisService;

  FoodAnalysisRepositoryImpl(this._analysisService);

  @override
  Future<List<FoodDetectionResult>> analyzeFoodImage(Uint8List imageBytes) async {
    return await _analysisService.analyzeFoodImage(imageBytes);
  }
}
