part of 'blog_upload_bloc.dart';

abstract class BlogUploadState extends Equatable {
  const BlogUploadState();
}

class BlogUploadInitial extends BlogUploadState {
  @override
  List<Object> get props => [];
}
