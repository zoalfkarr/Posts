class PostModel {
  final dynamic id;
  final String userid;
  final String title;
  final String body;

  PostModel({
    required this.id,
    required this.userid,
    required this.title,
    required this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json["id"],
      userid: (json["userId"] ?? json["userid"] ?? '').toString(),
      title: json["title"]?.toString() ?? '',
      body: json["body"]?.toString() ?? '',
    );
  }
}
