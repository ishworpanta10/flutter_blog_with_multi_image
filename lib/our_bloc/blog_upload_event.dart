part of 'blog_upload_bloc.dart';

abstract class BlogUploadEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BlogUploadFirstEvent extends BlogUploadEvent {
  BlogUploadFirstEvent({required this.blogModel, required this.pickedFileList});
  final BlogModel blogModel;
  final List<PickedFile> pickedFileList;

  @override
  List<Object?> get props => [blogModel, pickedFileList];
}
