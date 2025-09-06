import 'package:flutter/material.dart';
import '../models/github_api.dart';
import 'repo_viewer_screen.dart';

class RepoSelectorScreen extends StatefulWidget {
  const RepoSelectorScreen({super.key});

  @override
  State<RepoSelectorScreen> createState() => _RepoSelectorScreenState();
}

class _RepoSelectorScreenState extends State<RepoSelectorScreen> {
  final TextEditingController _usernameController = TextEditingController();
  List<Map<String, dynamic>> _repos = [];
  bool _loading = false;
  String? _error;

  Future<void> _fetchRepos() async {
    final username = _usernameController.text;
    if (username.isEmpty) {
      setState(() {
        _error = "Please enter a GitHub username.";
        _repos = [];
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
      _repos = [];
    });

    try {
      final data = await GitHubApi.fetchUserRepos(username);
      setState(() {
        _repos = List<Map<String, dynamic>>.from(data);
      });
    } catch (e) {
      setState(() {
        _error = "Failed to load repositories. Please check the username.";
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(flex: 2),
            Text(
              "CodeLens",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Enter GitHub Username',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _fetchRepos,
                ),
              ),
              onSubmitted: (_) => _fetchRepos(),
            ),
            const SizedBox(height: 20),
            if (_loading)
              const Center(child: CircularProgressIndicator())
            else if (_error != null)
              Center(
                child: Text(_error!, style: const TextStyle(color: Colors.red)),
              )
            else if (_repos.isNotEmpty)
              SizedBox(
                height: 300, // Fixed height to show 4-5 items
                child: ListView.builder(
                  itemCount: _repos.length,
                  itemBuilder: (context, index) {
                    final repo = _repos[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.folder_open, size: 40),
                          title: Text(
                            repo['name'],
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(repo['owner']['login']),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RepoViewerScreen(
                                  owner: repo['owner']['login'],
                                  repo: repo['name'],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              const Center(child: Text("Start by entering a username.")),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
