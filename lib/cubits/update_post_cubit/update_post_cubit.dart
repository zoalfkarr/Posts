import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/update_post_service.dart';
import 'update_post_state.dart';

class UpdatePostCubit extends Cubit<UpdatePostState> {
  UpdatePostCubit() : super(UpdatePostInitial());

  Future<void> updateProduct({
    required String title,
    required String userid,
    required String body,
    required int id,
  }) async {
    emit(UpdatePostLoading());
    try {
      await UpdatePostService().updatePost(
        title: title,
        body: body,
        id: id,
        userid: userid,
      );
      emit(UpdatePostSuccess());
    } catch (e) {
      emit(UpdatePostFailure(errorMessage: e.toString()));
    }
  }
}
