import 'package:flutter/material.dart';
import 'dart:convert';
import '../../data/models/nutrition_summary.dart';
import 'widgets/nutrition_summary_widget.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final nutritionSummary = arguments['nutritionSummary'] as NutritionSummary;
    final analysisResult = arguments['analysisResult'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NutritionSummaryWidget(summary: nutritionSummary),
            
            const SizedBox(height: 24),
            
            const Text(
              'Raw JSON Response',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 16),
            
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    JsonEncoder.withIndent('  ').convert(
                      analysisResult.map((result) => result.toJson()).toList()
                    ),
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Tracking'),
            ),
          ],
        ),
      ),
    );
  }
}