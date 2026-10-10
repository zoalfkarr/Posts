import '../helper/api.dart';
import '../models/post_model.dart';

class AddPost {
  Future<PostModel> addPost({
    required String title,
    required String body,
  }) async {
    dynamic responseData = await Api().post(
      url: "https://jsonplaceholder.typicode.com/posts",
      body: {"title": title, "body": body, "userId": 1},
    );
    return PostModel.fromJson(responseData as Map<String, dynamic>);
  }
}
