import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'blog_upload_event.dart';
part 'blog_upload_state.dart';

class BlogUploadBloc extends Bloc<BlogUploadEvent, BlogUploadState> {
  BlogUploadBloc() : super(BlogUploadInitial());

  @override
  Stream<BlogUploadState> mapEventToState(
    BlogUploadEvent event,
  ) async* {
    if (event is BlogUploadFirstEvent) {
      yield* _mapBlogUploadInitailEventToState(event);
    }
  }

  Stream<BlogUploadState> _mapBlogUploadInitailEventToState(
      BlogUploadFirstEvent event) async* {
    yield BlogUploadProgress();

    try {} catch (err) {
      debugPrint("Button Pressed $err");
    }
  }
}
