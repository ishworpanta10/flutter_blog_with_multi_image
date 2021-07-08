import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Image Picker With Bloc'),
      ),
      body: Container(
        child: Center(
          child: Text('Multi Image Picker With Bloc'),
        ),
      ),
    );
  }
}
