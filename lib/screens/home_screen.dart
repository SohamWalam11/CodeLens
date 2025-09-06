import 'package:flutter/material.dart';
import 'repo_selector_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dev Recommender")),
      body: Center(
        child: ElevatedButton(
          child: const Text("Select Repository"),
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (_) => const RepoSelectorScreen()));
          },
        ),
      ),
    );
  }
}
