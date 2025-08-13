import 'package:flutter/material.dart';
import 'dart:typed_data';
import '../../data/models/food_detection_result.dart';
import '../../domain/repositories/food_analysis_repository.dart';

class FoodAnalysisProvider extends ChangeNotifier {
  final FoodAnalysisRepository _repository;

  FoodAnalysisProvider(this._repository);

  List<FoodDetectionResult>? _analysisResult;
  bool _isLoading = false;
  Uint8List? _selectedImageBytes;

  List<FoodDetectionResult>? get analysisResult => _analysisResult;
  bool get isLoading => _isLoading;
  Uint8List? get selectedImageBytes => _selectedImageBytes;

  Future<void> analyzeFoodImage(Uint8List imageBytes) async {
    try {
      _setLoading(true);
      _selectedImageBytes = imageBytes;

      final result = await _repository.analyzeFoodImage(imageBytes);
      _analysisResult = result;

    } catch (e) {
      _analysisResult = null;
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  void setSelectedImage(Uint8List imageBytes) {
    _selectedImageBytes = imageBytes;
    notifyListeners();
  }

  void clearAnalysis() {
    _analysisResult = null;
    _selectedImageBytes = null;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
