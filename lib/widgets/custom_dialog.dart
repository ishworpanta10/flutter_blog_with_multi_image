import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              width: 30,
            ),
            Text(message ?? 'Loading ....'),
          ],
        ),
      ),
    );
  }
}
