import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entities/post_entity.dart';
import '../../constants/gaps.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/media/media_bloc.dart';
import '../../logic/post/post_bloc.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, postState) {},
      builder: (context, postState) {
        return BlocConsumer<MediaBloc, MediaState>(
          listener: (context, mediaState) {
            if (mediaState is MediaFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(mediaState.error ?? ''),
                ),
              );
            }
          },
          builder: (context, mediaState) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Create Post'),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
                actions: [
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, authState) {
                    },
                    builder: (context, authState) {
                      return IconButton(
                        onPressed: () {
                          final postEntity = PostEntity(
                            postId: Uuid().v6(),
                            userId: authState.userCredential?.user!.uid ?? '',
                            description: _descriptionController.text,
                          );
                          context
                              .read<PostBloc>()
                              .add(SavePostToDbEvent(postEntity));
                          context.read<PostBloc>().add(UploadPostEvent(
                                postEntity.postId ?? '',
                                mediaState.fileImage!.file,
                              ));
                          Navigator.pushNamed(context, '/home-page');
                        },
                        icon: Icon(Icons.check),
                      );
                    },
                  )
                ],
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Gaps.large, vertical: Gaps.large),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context
                              .read<MediaBloc>()
                              .add(UploadPictureFromGalleryEvent());
                        },
                        child: Center(
                          child: SizedBox(
                            height: 550,
                            child: mediaState.fileImage != null
                                ? Image.file(mediaState.fileImage!.file)
                                : Image.network(
                                    'https://www.paperplace.com.au/cdn/shop/products/via-felt-white.jpg?v=1458264914',
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: Gaps.largest),
                      Text(
                        'Description',
                        style: TextStyle(fontSize: 16),
                      ),
                      TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          hintText: 'Write a description',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
