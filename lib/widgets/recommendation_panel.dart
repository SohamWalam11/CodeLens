import 'package:flutter/material.dart';

class RecommendationPanel extends StatelessWidget {
  final String? filePath;
  final String code;

  const RecommendationPanel({
    super.key,
    required this.filePath,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    final recs = [
      "Optimize imports",
      "Refactor long methods",
      "Use proper naming conventions",
    ];

    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.blue[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recommendations for: ${filePath ?? "No file selected"}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // ✅ Removed .toList()
          ...recs.map((r) => Text("• $r")),
        ],
      ),
    );
  }
}
