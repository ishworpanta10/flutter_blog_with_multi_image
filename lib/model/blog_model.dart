class BlogModel {
  BlogModel({
    this.id,
    required this.title,
    this.subTitle,
    required this.imageList,
  });

  factory BlogModel.fromMap(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      title: json['title'],
      subTitle: json['subTitle'],
      imageList: ['imageList'],
    );
  }

  String? id;
  String title;
  String? subTitle;
  List<String> imageList;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subTitle': subTitle,
      'imageList': imageList,
    };
  }
}
