import '../helper/api.dart';

class AllCategoriesService {
  Future<List<dynamic>> getAllPosts() async {
    List<dynamic> data = await Api().get(
      url: "https://jsonplaceholder.typicode.com/posts",
    );
    return data;
  }
}
