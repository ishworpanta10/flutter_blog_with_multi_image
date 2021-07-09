import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class FirebaseStorageService {
  static Future<firebase_storage.UploadTask?> uploadImage(
      String destination, File file) async {
    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      debugPrint("Error Image Upload : ${e.message}");
      return null;
    }
  }

  Future<List<String>> uploadFileAndReturnListOfUrl(
      List<PickedFile> fileList) async {
    final imageUrlList = <String>[];
    for (final file in fileList) {
      firebase_storage.Reference ref;
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(file.path)}');

      await ref.putFile(File(file.path)).whenComplete(() async {
        await ref.getDownloadURL().then(imageUrlList.add);
      });
    }
    return imageUrlList;
  }
}
