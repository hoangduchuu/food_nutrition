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
        title: const Text('Food Nutrition Analyzer'),
      ),
      body: Consumer<FoodAnalysisProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image Upload Section
                const ImageUploadWidget(),
                
                const SizedBox(height: 24),
                
                // Analysis Button
                if (provider.selectedImageBytes != null && !provider.isLoading)
                  ElevatedButton.icon(
                    onPressed: () => _analyzeImage(context, provider),
                    icon: const Icon(Icons.analytics),
                    label: const Text('Analyze Food'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                
                const SizedBox(height: 24),
                
                // Loading State
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
                
                // Error State
                if (provider.error != null && !provider.isLoading)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      border: Border.all(color: Colors.red.shade200),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.error, color: Colors.red.shade600),
                            const SizedBox(width: 8),
                            const Text(
                              'Analysis Failed',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          provider.error!,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ],
                    ),
                  ),
                
                const SizedBox(height: 24),
                
                // Nutrition Summary
                if (provider.nutritionSummary != null) ...[
                  NutritionSummaryWidget(summary: provider.nutritionSummary!),
                  const SizedBox(height: 24),
                ],
                
                // Raw JSON Results
                if (provider.analysisResult != null) ...[
                  const Text(
                    'Raw JSON Response',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Container(
                    constraints: const BoxConstraints(maxHeight: 400),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildJsonLines(provider.analysisResult!),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Clear Button
                  OutlinedButton.icon(
                    onPressed: provider.clearAnalysis,
                    icon: const Icon(Icons.clear),
                    label: const Text('Clear Analysis'),
                  ),
                ],
                
                // Add bottom padding for better scrolling
                const SizedBox(height: 50),
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

  List<Widget> _buildJsonLines(List<dynamic> results) {
    final jsonString = JsonEncoder.withIndent('  ').convert(
      results.map((result) => result.toJson()).toList()
    );
    final lines = jsonString.split('\n');
    
    return lines.map((line) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: Text(
          line,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
          ),
        ),
      );
    }).toList();
  }
}
