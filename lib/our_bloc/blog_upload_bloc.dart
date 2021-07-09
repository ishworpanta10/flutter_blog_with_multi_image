import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../model/blog_model.dart';
import '../services/firebase_firestore_service.dart';

part 'blog_upload_event.dart';
part 'blog_upload_state.dart';

class BlogUploadBloc extends Bloc<BlogUploadEvent, BlogUploadState> {
  BlogUploadBloc({required this.firebaseFirestoreService})
      : super(BlogUploadInitial());
  FirebaseFirestoreService firebaseFirestoreService =
      FirebaseFirestoreService();

  @override
  Stream<BlogUploadState> mapEventToState(
    BlogUploadEvent event,
  ) async* {
    if (event is BlogUploadFirstEvent) {
      yield* _mapBlogUploadFirstEventToState(event);
    }
  }

  Stream<BlogUploadState> _mapBlogUploadFirstEventToState(
      BlogUploadFirstEvent event) async* {
    yield BlogUploadProgress();

    try {
      final imageList = event.blogModel.imageList;

      //  uploading image to Firebase Firestore
      final blogModel = BlogModel(
        title: event.blogModel.title,
        subTitle: event.blogModel.subTitle,
        imageList: [],
      );
      //  uploading data to firebase database
      await firebaseFirestoreService.uploadBlogDataToFirebase(blogModel);

      yield BlogUploadSuccess(
        imageList: [],
      );
    } catch (err) {
      yield BlogUploadError(
        errorMessage: err.toString(),
      );
      debugPrint("Button Pressed $err");
    }
  }
}
