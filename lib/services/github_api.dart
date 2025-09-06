class GitHubApi {
  Future<List<String>> fetchRepoStructure(String repo) async {
    // Mock implementation
    return ["lib/main.dart", "lib/screens/home_screen.dart"];
  }

  Future<String> fetchFileContent(String path) async {
    return "// Code for $path";
  }
}
