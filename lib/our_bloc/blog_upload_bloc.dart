import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/blog_model.dart';
import '../services/firebase_firestore_service.dart';
import '../services/firebase_storage_service.dart';

part 'blog_upload_event.dart';
part 'blog_upload_state.dart';

class BlogUploadBloc extends Bloc<BlogUploadEvent, BlogUploadState> {
  BlogUploadBloc(
      {required this.firebaseFirestoreService,
      required this.firebaseStorageService})
      : super(BlogUploadInitial());
  FirebaseFirestoreService firebaseFirestoreService =
      FirebaseFirestoreService();

  FirebaseStorageService firebaseStorageService = FirebaseStorageService();

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
      final pickedFileList = event.pickedFileList;

      //  uploading image to Firebase Firestore

      final imageList = await firebaseStorageService
          .uploadFileAndReturnListOfUrl(pickedFileList);

      //model
      final blogModel = BlogModel(
        title: event.blogModel.title,
        subTitle: event.blogModel.subTitle,
        imageList: imageList,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      //  uploading data to firebase database
      await firebaseFirestoreService.uploadBlogDataToFirebase(blogModel);

      yield BlogUploadSuccess(blogModel: blogModel);
    } catch (err) {
      yield BlogUploadError(
        errorMessage: err.toString(),
      );
      debugPrint("Button Pressed $err");
    }
  }
}
