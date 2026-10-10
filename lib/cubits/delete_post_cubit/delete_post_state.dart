abstract class DeletePostState {}

class DeletePostInitial extends DeletePostState {}

class DeletePostLoading extends DeletePostState {
  final dynamic postId;
  DeletePostLoading({required this.postId});
}

class DeletePostSuccess extends DeletePostState {
  final dynamic postId;
  DeletePostSuccess({required this.postId});
}

class DeletePostFailure extends DeletePostState {
  final String errorMessage;
  final dynamic postId;
  DeletePostFailure({required this.errorMessage, required this.postId});
}
