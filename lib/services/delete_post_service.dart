import '../helper/api.dart';

class DeletePostService {
  Future<void> deletePost({required dynamic id}) async {
    await Api().delete(url: "https://jsonplaceholder.typicode.com/posts/$id");
  }
}
