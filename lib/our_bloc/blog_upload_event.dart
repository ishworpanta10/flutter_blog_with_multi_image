part of 'blog_upload_bloc.dart';

abstract class BlogUploadEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BlogUploadFirstEvent extends BlogUploadEvent {
  BlogUploadFirstEvent({required this.blogModel});
  final BlogModel blogModel;

  @override
  List<Object?> get props => [blogModel];
}
