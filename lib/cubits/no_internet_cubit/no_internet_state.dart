abstract class DataState {}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataSuccess extends DataState {
  final List<dynamic> data;
  DataSuccess(this.data);
}

class DataError extends DataState {
  final String message;
  DataError(this.message);
}

class DataNoInternet extends DataState {}
