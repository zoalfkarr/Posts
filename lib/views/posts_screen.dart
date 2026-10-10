import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubits/home_cubit/home_cubit.dart';
import '../cubits/home_cubit/home_state.dart';
import '../widgets/no_internet_widget.dart';
import '../widgets/posts_list_view.dart';
import '../widgets/posts_search.dart';
import 'add_post_screen.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton<String>(
          icon: const Icon(Icons.reorder),
          tooltip: 'Options',
          onSelected: (value) {
            if (value == 'refresh') {
              context.read<HomeCubit>().getAllPosts();
            } else if (value == 'about') {
              showAboutDialog(
                context: context,
                applicationName: 'Posts List',
                applicationVersion: '1.0.0',
              );
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'refresh',
              child: Row(
                children: [
                  const Icon(Icons.refresh, color: Colors.black),
                  const SizedBox(width: 8),
                  Text('refresh', style: GoogleFonts.notoSerif()),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'about',
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.black),
                  const SizedBox(width: 8),
                  Text('about', style: GoogleFonts.notoSerif()),
                ],
              ),
            ),
          ],
        ),

        title: Text(
          'All Posts',
          style: GoogleFonts.notoSerif(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,

        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            onPressed: () {
              final state = context.read<HomeCubit>().state;
              if (state is HomeSuccess) {
                showSearch(
                  context: context,
                  delegate: PostSearchDelegate(state.posts),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Please wait for the posts to load.',
                      style: GoogleFonts.notoSerif(),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeSuccess) {
            return PostsListView(posts: state.posts);
          } else if (state is HomeNoInternet) {
            return NoInternet();
          } else if (state is HomeFailure) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<HomeCubit>().getAllPosts();
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.errorMessage,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.notoSerif(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<HomeCubit>(context).getAllPosts();
                            },
                            child: Text(
                              'Try Again',
                              style: GoogleFonts.notoSerif(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPostScreen()),
          );
        },
        backgroundColor: Colors.amberAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
