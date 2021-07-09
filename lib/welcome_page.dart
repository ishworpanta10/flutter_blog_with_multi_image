import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'our_bloc/blog_upload_bloc.dart';
import 'our_bloc/image_picked_bloc.dart';
import 'screen/home_page.dart';
import 'services/firebase_firestore_service.dart';
import 'services/firebase_storage_service.dart';

class WelcomePage extends StatelessWidget {
  final FirebaseFirestoreService _firebaseFirestoreService =
      FirebaseFirestoreService();
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlogUploadBloc>(
          create: (_) => BlogUploadBloc(
            firebaseFirestoreService: _firebaseFirestoreService,
            firebaseStorageService: _firebaseStorageService,
          ),
        ),
        BlocProvider<ImagePickedBloc>(
          create: (_) => ImagePickedBloc(),
        )
      ],
      child: HomePage(),
    );
  }
}
