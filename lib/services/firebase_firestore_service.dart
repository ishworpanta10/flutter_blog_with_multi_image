import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firebase_collection/firebase_collection.dart';
import '../model/blog_model.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> uploadBlogDataToFirebase(BlogModel blogModel) async {
    final blogCollection =
        firebaseFirestore.collection(FirbaseCollectionConstants.blogCollection);

    final id = blogCollection.doc().id;
    blogModel.id = id;
    await blogCollection.doc(id).set(
          blogModel.toMap(),
        );
  }
}
