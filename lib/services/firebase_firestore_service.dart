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

  Stream<List<BlogModel>> getStreamOfBlogList() {
    //collection
    final blogCollection =
        firebaseFirestore.collection(FirbaseCollectionConstants.blogCollection);
    //snapdata
    return blogCollection
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .map((querySnap) {
      //QuerySnapshot<Map<String, dynamic>>
      return querySnap.docs.map((queryDocSnap) {
        // QueryDocumentSnapshot<Map<String, dynamic>> queryDocSnap
        final data = queryDocSnap.data();
        data.putIfAbsent('id', () => queryDocSnap.id);
        return BlogModel.fromMap(data);
      }).toList();
    });
  }
}
