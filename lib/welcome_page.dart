import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'our_bloc/blog_upload_bloc.dart';
import 'our_bloc/image_picked_bloc.dart';
import 'screen/home_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlogUploadBloc>(
          create: (_) => BlogUploadBloc(),
        ),
        BlocProvider<ImagePickedBloc>(
          create: (_) => ImagePickedBloc(),
        )
      ],
      child: const HomePage(),
    );
  }
}
