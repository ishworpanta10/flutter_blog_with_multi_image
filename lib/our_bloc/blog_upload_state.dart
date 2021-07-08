part of 'blog_upload_bloc.dart';

abstract class BlogUploadState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BlogUploadInitial extends BlogUploadState {}

class BlogUploadProgress extends BlogUploadState {}

class BlogUploadSuccess extends BlogUploadState {
  BlogUploadSuccess({required this.imageList, this.title, this.subTitle});
  final List<String> imageList;
  final String? title;
  final String? subTitle;
  @override
  List<Object?> get props => [imageList, title, subTitle];
}

class BlogUploadError extends BlogUploadState {
  BlogUploadError({required this.errorMessage});
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
