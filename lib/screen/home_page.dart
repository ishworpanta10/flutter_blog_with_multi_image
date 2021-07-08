import 'package:flutter/material.dart';

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
              onPressed: () {},
              icon: const Icon(Icons.add_a_photo_outlined),
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
