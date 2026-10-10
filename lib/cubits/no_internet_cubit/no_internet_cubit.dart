import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helper/api.dart';
import 'no_internet_state.dart';

class DataCubit extends Cubit<DataState> {
  final Api apiService;

  DataCubit(this.apiService) : super(DataInitial());

  Future<void> fetchData() async {
    emit(DataLoading());

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      emit(DataNoInternet());
      return;
    }

    try {
      final data = await apiService.get(
        url: "https://jsonplaceholder.typicode.com/posts",
      );
      emit(DataSuccess(data));
    } catch (e) {
      if (e.toString().contains('SocketException') ||
          e.toString().contains('Failed host lookup')) {
        emit(DataNoInternet());
      } else {
        emit(DataError("Failed ${e.toString()}"));
      }
    }
  }
}
