import 'package:flutter/material.dart';
import '../models/repo.dart';
import '../widgets/folder_tree.dart';
import '../widgets/code_viewer.dart';
import '../widgets/recommendation_panel.dart';

class FileViewerScreen extends StatefulWidget {
  final Repo repo;

  const FileViewerScreen({super.key, required this.repo});

  @override
  State<FileViewerScreen> createState() => _FileViewerScreenState();
}

class _FileViewerScreenState extends State<FileViewerScreen> {
  String? selectedFile;
  String fileContent = "// Select a file to view code";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.repo.name)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Use a Row layout for wide screens
            return Row(
              children: [
                // Folder tree (files list)
                Expanded(
                  flex: 2,
                  child: FolderTree(
                    owner: widget.repo.owner,
                    repo: widget.repo.name,
                    onFileSelected: (path, content) {
                      setState(() {
                        selectedFile = path;
                        fileContent = content;
                      });
                    },
                  ),
                ),
                // Code viewer
                Expanded(flex: 3, child: CodeViewer(code: fileContent)),
                // Recommendation panel
                Expanded(
                  flex: 2,
                  child: RecommendationPanel(
                    filePath: selectedFile,
                    code: fileContent,
                  ),
                ),
              ],
            );
          } else {
            // Use a Column layout for narrow screens
            return Column(
              children: [
                // Folder tree (files list)
                Expanded(
                  flex: 1,
                  child: FolderTree(
                    owner: widget.repo.owner,
                    repo: widget.repo.name,
                    onFileSelected: (path, content) {
                      setState(() {
                        selectedFile = path;
                        fileContent = content;
                      });
                    },
                  ),
                ),
                // Code viewer
                Expanded(flex: 1, child: CodeViewer(code: fileContent)),
                // Recommendation panel
                Expanded(
                  flex: 1,
                  child: RecommendationPanel(
                    filePath: selectedFile,
                    code: fileContent,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
