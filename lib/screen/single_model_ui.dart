import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/blog_model.dart';

class SingleModelUI extends StatelessWidget {
  const SingleModelUI({required this.blogModel});
  final BlogModel blogModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(blogModel.title),
          subtitle: Text(blogModel.subTitle ?? ""),
        ),
        if (blogModel.imageList.isEmpty)
          const SizedBox()
        else
          Container(
            height: 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(blogModel.imageList.length, (index) {
                  return Padding(
                    padding:
                        EdgeInsets.only(left: index == 0 ? 20 : 0, right: 20),
                    child: GestureDetector(
                      onTap: () async {
                        await showDialog(
                          context: context,
                          barrierColor: Colors.black.withOpacity(0.7),
                          builder: (dContext) {
                            return AlertDialog(
                              content: CachedNetworkImage(
                                // width: 250,
                                // height: 250,
                                // fit: BoxFit.cover,
                                imageUrl: blogModel.imageList[index],
                                placeholder: (context, url) {
                                  return const Center(
                                    child: CupertinoActivityIndicator(),
                                  );
                                },
                                errorWidget: (context, url, d) {
                                  return const Center(
                                    child: Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: CachedNetworkImage(
                          height: 130,
                          imageUrl: blogModel.imageList[index],
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
      ],
    );
  }
}
