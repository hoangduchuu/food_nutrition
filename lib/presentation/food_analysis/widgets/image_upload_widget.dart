import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import '../food_analysis_provider.dart';

class ImageUploadWidget extends StatelessWidget {
  const ImageUploadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FoodAnalysisProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            // Image selection button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _selectImage(context),
                icon: const Icon(Icons.add_photo_alternate),
                label: const Text('Select Image'),
              ),
            ),
            
            // Selected image preview
            if (provider.selectedImageBytes != null) ...[
              const SizedBox(height: 20),
              Container(
                height: 300,
                width: double.infinity,
                child: Stack(
                  children: [
                    Center(
                      child: Image.memory(
                        provider.selectedImageBytes!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        onPressed: () => provider.clearAnalysis(),
                        icon: const Icon(Icons.close),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.8),
                          shape: const CircleBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  void _selectImage(BuildContext context) {
    final input = html.FileUploadInputElement()
      ..accept = 'image/*'
      ..click();

    input.onChange.listen((event) {
      final file = input.files?.first;
      if (file != null) {
        final reader = html.FileReader();
        reader.onLoad.listen((event) {
          final bytes = reader.result as Uint8List;
          final provider = context.read<FoodAnalysisProvider>();
          provider.setSelectedImage(bytes);
        });
        reader.readAsArrayBuffer(file);
      }
    });
  }
}
