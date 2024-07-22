// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/assets.dart';

class MediaBottomSheetWidget extends StatelessWidget {
  const MediaBottomSheetWidget({super.key, this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        Assets.plusIcon,
        height: 24,
        width: 24,
        color: Color.fromARGB(255, 159, 156, 156),
      ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              height: 430,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        final titles = [
                          'Reel',
                          'Post',
                          'Story',
                          'Story Highlight',
                          'Live',
                          'Guide',
                        ];
                        final icons = [
                          Icons.video_collection_outlined,
                          Icons.square_outlined,
                          Icons.add_circle_outline_outlined,
                          Icons.highlight_outlined,
                          Icons.leak_remove_outlined,
                          Icons.menu_book,
                        ];
                        return Card(
                          elevation: 0,
                          child: InkWell(
                            onTap: () {
                              if (index == 1) {
                                Navigator.pushNamed(
                                    context, '/create-post-page');
                              }
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(255, 194, 201, 207),
                                child: Icon(icons[index]),
                              ),
                              title: Text(titles[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
