class FileNode {
  final String path;
  final bool isFolder;
  final List<FileNode> children;
  FileNode({required this.path, this.isFolder = false, this.children = const []});
}
