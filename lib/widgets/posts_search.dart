import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posts/widgets/posts_list_view.dart';

import '../models/post_model.dart';

class PostSearchDelegate extends SearchDelegate {
  final List<PostModel> posts;

  PostSearchDelegate(this.posts);

  @override
  String? get searchFieldLabel => 'Search in Posts';

  @override
  TextStyle? get searchFieldStyle => GoogleFonts.notoSerif(fontSize: 16);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final filteredList = posts.where((post) {
      final titleMatch = post.title.toLowerCase().contains(query.toLowerCase());
      final bodyMatch = post.body.toLowerCase().contains(query.toLowerCase());
      return titleMatch || bodyMatch;
    }).toList();

    if (filteredList.isEmpty) {
      return Center(
        child: Text(
          'No results found',
          style: GoogleFonts.notoSerif(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return PostsListView(posts: filteredList);
  }
}
