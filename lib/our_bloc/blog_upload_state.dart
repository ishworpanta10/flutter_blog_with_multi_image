part of 'blog_upload_bloc.dart';

abstract class BlogUploadState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BlogUploadInitial extends BlogUploadState {}

class BlogUploadProgress extends BlogUploadState {}

class BlogUploadSuccess extends BlogUploadState {
  BlogUploadSuccess({required this.blogModel});
  final BlogModel blogModel;
  @override
  List<Object?> get props => [blogModel];
}

class BlogUploadError extends BlogUploadState {
  BlogUploadError({required this.errorMessage});
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
