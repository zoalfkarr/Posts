import '../helper/api.dart';
import '../models/post_model.dart';

class AllPostService {
  Future<List<PostModel>> getAllPosts() async {
    List<dynamic> data = await Api().get(
      url: "https://jsonplaceholder.typicode.com/posts",
    );

    List<PostModel> postList = [];
    for (int i = 0; i < data.length; i++) {
      postList.add(PostModel.fromJson(data[i] as Map<String, dynamic>));
    }
    return postList;
  }
}
