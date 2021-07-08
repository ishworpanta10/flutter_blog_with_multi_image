import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../our_bloc/image_picked_bloc.dart';
import 'upload_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                      child: UploadPage(),
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
      body: const Center(
        child: Text('Multi Image Picker With Bloc'),
      ),
    );
  }
}
