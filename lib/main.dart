import 'package:flutter/material.dart';
import 'screens/repo_selector_screen.dart';

void main() {
  runApp(const DevRecommenderApp());
}

class DevRecommenderApp extends StatelessWidget {
  const DevRecommenderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dev Recommender',
      theme: ThemeData(
        // Set up a modern color scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const RepoSelectorScreen(),
    );
  }
}
