import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Nutrition App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'API Testing',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                
                ElevatedButton(
                  onPressed: homeProvider.isLoading 
                      ? null 
                      : () => homeProvider.testSuccessCall(),
                  child: const Text('Test Success Call'),
                ),
                
                const SizedBox(height: 16),
                
                ElevatedButton(
                  onPressed: homeProvider.isLoading 
                      ? null 
                      : () => homeProvider.testErrorCall(),
                  child: const Text('Test Error Call'),
                ),
                
                const SizedBox(height: 32),
                
                if (homeProvider.currentTodo != null)
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Current Todo:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('ID: ${homeProvider.currentTodo!.id}'),
                        Text('Title: ${homeProvider.currentTodo!.title}'),
                        Text('Completed: ${homeProvider.currentTodo!.completed}'),
                        Text('User ID: ${homeProvider.currentTodo!.userId}'),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}