import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../../utils/loading_utils.dart';
import 'food_analysis_provider.dart';
import 'widgets/image_upload_widget.dart';
import 'widgets/nutrition_summary_widget.dart';

class FoodAnalysisScreen extends StatelessWidget {
  const FoodAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Tracking'),
      ),
      body: Consumer<FoodAnalysisProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ImageUploadWidget(),
                
                const SizedBox(height: 24),
                
                if (provider.selectedImageBytes != null && !provider.isLoading)
                  ElevatedButton(
                    onPressed: () => _analyzeImage(context, provider),
                    child: const Text('Analyze Food'),
                  ),
                
                const SizedBox(height: 24),
                
                if (provider.isLoading)
                  const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Analyzing your food...'),
                      ],
                    ),
                  ),
                
                if (provider.error != null && !provider.isLoading)
                  Text(
                    'Error: ${provider.error!}',
                    style: TextStyle(color: Colors.red),
                  ),
                
                if (provider.nutritionSummary != null && !provider.isLoading) ...[
                  Text(
                    'Total: ${provider.nutritionSummary!.totalCalories.toStringAsFixed(0)} cal',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/results',
                      arguments: {
                        'nutritionSummary': provider.nutritionSummary,
                        'analysisResult': provider.analysisResult,
                      },
                    ),
                    child: const Text('View Results'),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _analyzeImage(BuildContext context, FoodAnalysisProvider provider) async {
    try {
      LoadingUtils.showProgress(message: 'Analyzing food...');
      await provider.analyzeFoodImage(provider.selectedImageBytes!);
      LoadingUtils.showSuccessMessage('Food analysis completed!');
    } catch (e) {
      LoadingUtils.showErrorMessage('Failed to analyze food: $e');
    }
  }
}
