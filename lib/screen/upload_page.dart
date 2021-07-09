import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../model/blog_model.dart';
import '../our_bloc/blog_upload_bloc.dart';
import '../our_bloc/image_picked_bloc.dart';
import '../widgets/custom_dialog.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final TextEditingController _textTitleEditingController =
      TextEditingController();

  final TextEditingController _textSubTitleEditingController =
      TextEditingController();

  List<File> imageList = [];

  final picker = ImagePicker();

  void _resetBloc() {
    context.read<ImagePickedBloc>().add(null);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlogUploadBloc, BlogUploadState>(
      listener: (context, blogUploadState) {
        if (blogUploadState is BlogUploadProgress) {
          // BotToast.showLoading();
          showDialog(
            context: context,
            builder: (context) => const CustomDialog(
              message: 'Adding Blog ....',
            ),
          );
        } else if (blogUploadState is BlogUploadError) {
          BotToast.showText(text: blogUploadState.errorMessage);
          BotToast.closeAllLoading();
        } else if (blogUploadState is BlogUploadSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          BotToast.closeAllLoading();
          BotToast.showText(text: 'Blog Added');

          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Choose Multiple Images'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _resetBloc,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: BlocBuilder<ImagePickedBloc, List<PickedFile>>(
                builder: (context, imagePickedState) {
                  return IconButton(
                    onPressed: () {
                      final imageList =
                          imagePickedState.map((e) => e.path).toList();
                      final blogTitle = _textTitleEditingController.text;
                      final blogSubTitle = _textSubTitleEditingController.text;
                      final blogModel = BlogModel(
                        title: blogTitle,
                        subTitle: blogSubTitle,
                        imageList: imageList,
                      );
                      BlocProvider.of<BlogUploadBloc>(context).add(
                        BlogUploadFirstEvent(blogModel: blogModel),
                      );

                      context.read<ImagePickedBloc>().add(null);
                    },
                    icon: const Icon(Icons.upload_sharp),
                  );
                },
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                controller: _textTitleEditingController,
                decoration: const InputDecoration(
                  hintText: 'Blog Title',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                controller: _textSubTitleEditingController,
                decoration: const InputDecoration(hintText: 'Blog Subtitle'),
              ),
            ),
            Expanded(
              child: BlocBuilder<ImagePickedBloc, List<PickedFile>>(
                builder: (context, pickedImageState) {
                  return GridView.builder(
                    itemCount: pickedImageState.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Center(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                color: Colors.grey.withOpacity(0.2),
                                child: IconButton(
                                  onPressed: () => _chooseImage(context),
                                  icon: const Icon(Icons.add_a_photo),
                                ),
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(
                                      File(pickedImageState[index - 1].path)),
                                ),
                              ),
                            );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _chooseImage(BuildContext context) async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        BlocProvider.of<ImagePickedBloc>(context).add(pickedFile);
      }

      // setState(() {
      //   imageList.add(
      //     File(pickedFile!.path),
      //   );
      // });
    } catch (err) {
      //Retrieved lost data

      final lostData = await picker.getLostData();
      if (lostData.isEmpty) {
        return;
      }
      if (lostData.file != null) {
        imageList.add(File(lostData.file!.path));
      } else {
        debugPrint("File Path : ${lostData.file}");
      }
    }
  }
}
