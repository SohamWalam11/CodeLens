import 'package:flutter/material.dart';
import '../models/repo.dart';

class RepoCard extends StatelessWidget {
  final Repo repo;
  final VoidCallback onTap;
  const RepoCard({super.key, required this.repo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(repo.name),
        subtitle: Text(repo.owner),
        onTap: onTap,
      ),
    );
  }
}
