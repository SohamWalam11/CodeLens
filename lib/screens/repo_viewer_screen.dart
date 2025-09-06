import 'package:flutter/material.dart';
import '../widgets/code_viewer.dart';
import '../widgets/folder_tree.dart';
import '../widgets/recommendation_panel.dart';

class RepoViewerScreen extends StatefulWidget {
  final String owner;
  final String repo;

  const RepoViewerScreen({super.key, required this.owner, required this.repo});

  @override
  State<RepoViewerScreen> createState() => _RepoViewerScreenState();
}

class _RepoViewerScreenState extends State<RepoViewerScreen> {
  String? _selectedFilePath;
  String _fileContent = "Select a file from the list to view its content.";

  void _onFileSelected(String path, String content) {
    setState(() {
      _selectedFilePath = path;
      _fileContent = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.owner}/${widget.repo}')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Define a breakpoint for a wide layout
          if (constraints.maxWidth > 600) {
            // Wide screen layout
            return Row(
              children: [
                SizedBox(
                  width: 300, // Fixed width for the folder tree
                  child: FolderTree(
                    owner: widget.owner,
                    repo: widget.repo,
                    onFileSelected: _onFileSelected,
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(flex: 3, child: CodeViewer(code: _fileContent)),
                      const Divider(height: 1),
                      Expanded(
                        flex: 1,
                        child: RecommendationPanel(
                          filePath: _selectedFilePath,
                          code: _fileContent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            // Narrow screen layout (e.g., mobile)
            return Column(
              children: [
                Expanded(
                  child: FolderTree(
                    owner: widget.owner,
                    repo: widget.repo,
                    onFileSelected: _onFileSelected,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(flex: 3, child: CodeViewer(code: _fileContent)),
                      const Divider(height: 1),
                      Expanded(
                        flex: 1,
                        child: RecommendationPanel(
                          filePath: _selectedFilePath,
                          code: _fileContent,
                        ),
                      ),
                    ],
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
