import 'package:flutter/material.dart';

class CodeViewer extends StatelessWidget {
  final String code;
  const CodeViewer({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.grey[200],
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: Text(code, style: const TextStyle(fontFamily: 'monospace')),
        ),
      ),
    );
  }
}
