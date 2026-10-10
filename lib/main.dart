import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/add_post_cubit/add_post_cubit.dart';
import 'cubits/delete_post_cubit/delete_post_cubit.dart';
import 'cubits/home_cubit/home_cubit.dart';
import 'views/posts_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit()..getAllPosts(),
        ),
        BlocProvider<AddPostCubit>(create: (context) => AddPostCubit()),
        BlocProvider<DeletePostCubit>(create: (context) => DeletePostCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Posts App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PostsScreen(),
      ),
    );
  }
}
