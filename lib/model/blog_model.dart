import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel {
  BlogModel({
    this.id,
    required this.title,
    this.subTitle,
    required this.imageList,
    this.createdAt,
    this.updatedAt,
  });

  factory BlogModel.fromMap(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      title: json['title'],
      subTitle: json['subTitle'],
      imageList: json['imageList'].cast<String>(),
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] as Timestamp).toDate()
          : json['updatedAt'],
    );
  }

  String? id;
  String title;
  String? subTitle;
  List<String> imageList;
  DateTime? createdAt;
  DateTime? updatedAt;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subTitle': subTitle,
      'imageList': imageList,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
