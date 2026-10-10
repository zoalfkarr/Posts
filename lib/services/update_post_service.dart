import 'dart:developer';

import '../helper/api.dart';
import '../models/post_model.dart';

class UpdatePostService {
  Future<PostModel> updatePost({
    required int id,
    required String userid,
    required String title,
    required String body,
  }) async {
    log("post id =$id");
    Map<String, dynamic> data = await Api().put(
      url: "https://jsonplaceholder.typicode.com/posts/$id",
      body: {"title": title, "userid": userid, "body": body},
    );
    return PostModel.fromJson(data);
  }
}
