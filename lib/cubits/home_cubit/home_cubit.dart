import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/post_model.dart';
import '../../services/get_all_post_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getAllPosts() async {
    emit(HomeLoading());

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(HomeNoInternet());
      return;
    }

    try {
      List<PostModel> post = await AllPostService().getAllPosts();
      emit(HomeSuccess(posts: post));
    } catch (e) {
      if (e.toString().contains('SocketException') ||
          e.toString().contains('Failed host lookup')) {
        emit(HomeNoInternet());
      } else {
        emit(HomeFailure(errorMessage: e.toString()));
      }
    }
  }
}
