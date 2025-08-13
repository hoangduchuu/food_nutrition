import 'package:flutter/material.dart';
import 'dart:typed_data';
import '../../data/models/food_detection_result.dart';
import '../../data/models/nutrition_summary.dart';
import '../../domain/repositories/food_analysis_repository.dart';

class FoodAnalysisProvider extends ChangeNotifier {
  final FoodAnalysisRepository _repository;

  FoodAnalysisProvider(this._repository);

  List<FoodDetectionResult>? _analysisResult;
  NutritionSummary? _nutritionSummary;
  bool _isLoading = false;
  String? _error;
  Uint8List? _selectedImageBytes;

  List<FoodDetectionResult>? get analysisResult => _analysisResult;
  NutritionSummary? get nutritionSummary => _nutritionSummary;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Uint8List? get selectedImageBytes => _selectedImageBytes;

  Future<void> analyzeFoodImage(Uint8List imageBytes) async {
    try {
      _setLoading(true);
      _clearError();
      _selectedImageBytes = imageBytes;

      final result = await _repository.analyzeFoodImage(imageBytes);
      _analysisResult = result;
      _nutritionSummary = NutritionSummary.fromFoodItems(result);

    } catch (e) {
      _analysisResult = null;
      _nutritionSummary = null;
      _setError(e.toString());
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  void setSelectedImage(Uint8List imageBytes) {
    _selectedImageBytes = imageBytes;
    _clearError();
    notifyListeners();
  }

  void clearAnalysis() {
    _analysisResult = null;
    _nutritionSummary = null;
    _selectedImageBytes = null;
    _clearError();
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }
}
