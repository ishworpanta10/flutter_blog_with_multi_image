import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/blog_model.dart';
import '../our_bloc/blog_upload_bloc.dart';
import '../our_bloc/image_picked_bloc.dart';
import '../services/firebase_firestore_service.dart';
import 'single_model_ui.dart';
import 'upload_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final FirebaseFirestoreService _firebaseFirestoreService =
      FirebaseFirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Image Picker With Bloc'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => BlocProvider.value(
                      value: context.read<ImagePickedBloc>(),
                      child: BlocProvider.value(
                        value: context.read<BlogUploadBloc>(),
                        child: UploadPage(),
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.add_a_photo_outlined,
              ),
            ),
          )
        ],
      ),
      body: StreamBuilder<List<BlogModel>>(
        stream: _firebaseFirestoreService.getStreamOfBlogList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final data = snapshot.data;

            if (data != null) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final blogModel = data[index];
                  return SingleModelUI(
                    blogModel: blogModel,
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Something went wrong ....'),
              );
            }
          }
          return const Center(
            child: Text('Loading ....'),
          );
        },
      ),
    );
  }
}
