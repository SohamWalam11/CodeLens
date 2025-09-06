import 'package:flutter/material.dart';
import '../models/github_api.dart';

class FolderTree extends StatefulWidget {
  final String owner;
  final String repo;
  final void Function(String path, String content) onFileSelected;

  const FolderTree({
    super.key,
    required this.owner,
    required this.repo,
    required this.onFileSelected,
  });

  @override
  State<FolderTree> createState() => _FolderTreeState();
}

class _FolderTreeState extends State<FolderTree> {
  late GitHubApi api;
  List<Map<String, dynamic>> files = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    api = GitHubApi(owner: widget.owner, repo: widget.repo);
    _loadRepoTree();
  }

  Future<void> _loadRepoTree() async {
    try {
      final tree = await api.fetchRepoTree();
      // Filter only files
      final fileNodes = tree
          .where((node) => node["type"] == "blob")
          .map((node) => {"path": node["path"], "url": node["url"]})
          .toList();
      setState(() {
        files = List<Map<String, dynamic>>.from(fileNodes);
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      debugPrint("Error fetching repo tree: $e");
    }
  }

  Future<void> _onFileTap(String path) async {
    try {
      final content = await api.fetchFileContent(path);
      widget.onFileSelected(path, content);
    } catch (e) {
      debugPrint("Error fetching file content: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to load file: $path")));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (files.isEmpty) {
      return const Center(child: Text("No files found in this repository."));
    }

    return ListView.builder(
      itemCount: files.length,
      itemBuilder: (context, index) {
        final file = files[index];
        return ListTile(
          title: Text(file["path"]),
          leading: const Icon(Icons.insert_drive_file),
          onTap: () => _onFileTap(file["path"]),
        );
      },
    );
  }
}
