import 'dart:convert';
import 'package:http/http.dart' as http;

class GitHubApi {
  static const String baseUrl = "https://api.github.com";

  final String owner;
  final String repo;

  GitHubApi({required this.owner, required this.repo});

  // New static method to fetch user's repos
  static Future<List<dynamic>> fetchUserRepos(String username) async {
    final url = Uri.parse("$baseUrl/users/$username/repos");
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to fetch user repos: ${res.statusCode}");
    }
  }

  // Fetch repo tree (instance method)
  Future<List<dynamic>> fetchRepoTree() async {
    final url = Uri.parse(
      "$baseUrl/repos/$owner/$repo/git/trees/main?recursive=1",
    );
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data["tree"];
    } else {
      throw Exception("Failed to fetch repo tree: ${res.statusCode}");
    }
  }

  // Fetch file content (instance method)
  Future<String> fetchFileContent(String path) async {
    final url = Uri.parse("$baseUrl/repos/$owner/$repo/contents/$path");
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      if (data["encoding"] == "base64") {
        return utf8.decode(base64.decode(data["content"]));
      }
      return data["content"];
    } else {
      throw Exception("Failed to fetch file: ${res.statusCode}");
    }
  }
}
