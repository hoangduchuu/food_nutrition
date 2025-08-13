import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/food_detection_result.dart';

class OpenAIFoodAnalysisService {
  final Dio _dio = Dio();
  static const String _baseUrl = 'https://api.openai.com/v1/chat/completions';

  Future<List<FoodDetectionResult>> analyzeFoodImage(Uint8List imageBytes) async {
    try {
      final apiKey = dotenv.env['OPENAI_API_KEY'];
      if (apiKey == null) {
        throw Exception('OpenAI API key not found in environment variables');
      }

      // Convert image to base64
      final base64Image = base64Encode(imageBytes);

      final requestBody = {
        "model": "gpt-4o-mini",
        "messages": [
          {
            "role": "system",
            "content": "You are a helpful assistant that analyzes food images and responds ONLY with valid JSON that exactly matches this schema: {\"name\": string, \"calories\": number, \"protein\": number, \"carbs\": number, \"fat\": number}. Do not include any explanations, text, or formatting outside the JSON."
          },
          {
            "role": "user",
            "content": [
              {
                "type": "text",
                "text": "Detect all foods in the following image and return a JSON array of objects following the given schema."
              },
              {
                "type": "image_url",
                "image_url": {
                  "url": "data:image/jpeg;base64,$base64Image"
                }
              }
            ]
          }
        ],
        "max_tokens": 1000,
        "temperature": 0
      };

      final response = await _dio.post(
        _baseUrl,
        data: requestBody,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
        ),
      );

      if (response.statusCode == 200) {
        final content = response.data['choices'][0]['message']['content'];
        final jsonData = _parseJsonFromContent(content);
        
        if (jsonData is List) {
          return jsonData.map((item) => FoodDetectionResult.fromJson(item)).toList();
        } else {
          // If single object, wrap in list
          return [FoodDetectionResult.fromJson(jsonData)];
        }
      } else {
        throw Exception('API request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to analyze food image: $e');
    }
  }

  dynamic _parseJsonFromContent(String content) {
    // Remove any markdown code blocks
    String cleanedContent = content.trim();
    
    // Remove ```json and ``` markers
    if (cleanedContent.startsWith('```json')) {
      cleanedContent = cleanedContent.substring(7);
    } else if (cleanedContent.startsWith('```')) {
      cleanedContent = cleanedContent.substring(3);
    }
    
    if (cleanedContent.endsWith('```')) {
      cleanedContent = cleanedContent.substring(0, cleanedContent.length - 3);
    }
    
    // Clean up any remaining whitespace
    cleanedContent = cleanedContent.trim();
    
    // Check if JSON appears to be truncated
    if (cleanedContent.isNotEmpty && !cleanedContent.endsWith(']') && !cleanedContent.endsWith('}')) {
      throw Exception('JSON response appears to be truncated. Last 50 characters: ${cleanedContent.substring(cleanedContent.length - 50)}');
    }
    
    // Try to parse as JSON
    try {
      return jsonDecode(cleanedContent);
    } catch (e) {
      throw Exception('Failed to parse JSON from content: $e\nContent length: ${content.length}\nContent: $content');
    }
  }
}
