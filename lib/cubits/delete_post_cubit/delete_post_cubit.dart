import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/delete_post_service.dart';
import 'delete_post_state.dart';

class DeletePostCubit extends Cubit<DeletePostState> {
  DeletePostCubit() : super(DeletePostInitial());

  Future<void> deletePost({required dynamic id}) async {
    emit(DeletePostLoading(postId: id));
    try {
      await DeletePostService().deletePost(id: id);
      emit(DeletePostSuccess(postId: id));
    } catch (e) {
      emit(DeletePostFailure(errorMessage: e.toString(), postId: id));
    }
  }
}
