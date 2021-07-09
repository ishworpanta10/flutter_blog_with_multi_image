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

  Future<void> _handleUploadEvent(BuildContext context) async => Navigator.push(
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Multi Image Picker With Bloc'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _handleUploadEvent(context);
          },
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder<List<BlogModel>>(
          stream: _firebaseFirestoreService.getStreamOfBlogList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                final data = snapshot.data;

                if (data != null) {
                  if (data.isEmpty) {
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          _handleUploadEvent(context);
                        },
                        child: Container(
                            padding: const EdgeInsets.all(16),
                            child: const Text('No Blog Yet, Add Blog')),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final blogModel = data[index];
                        return SingleModelUI(
                          blogModel: blogModel,
                        );
                      },
                    );
                  }
                } else {
                  return const Center(
                    child: Text('Something went wrong ....'),
                  );
                }
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ),
      ),
    );
  }
}
