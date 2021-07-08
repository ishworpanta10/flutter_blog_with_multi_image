import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'blog_upload_event.dart';
part 'blog_upload_state.dart';

class BlogUploadBloc extends Bloc<BlogUploadEvent, BlogUploadState> {
  BlogUploadBloc() : super(BlogUploadInitial());

  @override
  Stream<BlogUploadState> mapEventToState(
    BlogUploadEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
