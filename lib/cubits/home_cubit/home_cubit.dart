import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/post_model.dart';
import '../../services/get_all_post_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getAllPosts() async {
    emit(HomeLoading());
    try {
      List<PostModel> post = await AllPostService().getAllPosts();
      emit(HomeSuccess(posts: post));
    } catch (e) {
      emit(HomeFailure(errorMessage: e.toString()));
    }
  }
}
