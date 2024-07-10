import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_entity.dart';
import '../../constants/gaps.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/media/media_bloc.dart';
import '../../logic/user/user_bloc.dart';
import 'widgets/int_on_string.dart';
import 'widgets/text_field_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.userEntity});
  final UserEntity? userEntity;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _nameController =
      TextEditingController(text: widget.userEntity?.name ?? '');
  late final TextEditingController _userNameController =
      TextEditingController(text: widget.userEntity?.username ?? '');
  late final TextEditingController _bioController =
      TextEditingController(text: widget.userEntity?.bio ?? '');

  @override
  void initState() {
    super.initState();
    if (widget.userEntity != null) {
      context
          .read<UserBloc>()
          .add(GetUserDataEvent(widget.userEntity!.userId ?? ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Username'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.control_point_duplicate_sharp,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_horiz_outlined, color: Colors.white),
              onPressed: () {},
            ),
          ]),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, userState) {
          if (userState is UserDataDbFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(userState.error ?? ''),
              ),
            );
          }
        },
        builder: (context, userState) {
          return BlocConsumer<AuthBloc, AuthState>(
              listener: (context, authState) {
            if (authState is SaveUserToDbFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(authState.error ?? '')),
              );
            }
          }, builder: (context, authState) {
            return Padding(
              padding: EdgeInsets.all(Gaps.large),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                      ),
                      IntOnString(count: '0', text: 'Posts'),
                      IntOnString(count: '0', text: 'Followers'),
                      IntOnString(count: '0', text: 'Following')
                    ],
                  ),
                  const Column(
                    children: [Text('Name'), Text('bio')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        child: const Text(
                          'Edit profile',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return BlocConsumer<MediaBloc, MediaState>(
                                listener: (context, mediaState) {
                                  if (mediaState is MediaFailed) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text(mediaState.error ?? '')),
                                    );
                                  }
                                },
                                builder: (context, mediaState) {
                                  return SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height - 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: EdgeInsets.all(Gaps.large),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                AppBar(
                                                  title: const Text(
                                                      'Edit profile'),
                                                  leading: IconButton(
                                                    icon:
                                                        const Icon(Icons.close),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  actions: [
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.check,
                                                          color: Color.fromRGBO(
                                                              1, 149, 247, 1)),
                                                      onPressed: () {
                                                        final userEntity =
                                                            UserEntity(
                                                          userId: authState
                                                              .userCredential
                                                              ?.user!
                                                              .uid,
                                                          email: authState
                                                              .userCredential
                                                              ?.user!
                                                              .email,
                                                          name: _nameController
                                                              .text,
                                                          bio: _bioController
                                                              .text,
                                                          username:
                                                              _userNameController
                                                                  .text,
                                                          // profileImage: mediaState.fileImage?.file.path
                                                        );
                                                        context
                                                            .read<UserBloc>()
                                                            .add(
                                                              UpdateUserDataEvent(
                                                                  userEntity,
                                                                  file: mediaState
                                                                      .fileImage
                                                                      ?.file),
                                                            );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 50,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                          backgroundColor:
                                                              const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  244,
                                                                  255,
                                                                  255),
                                                          context: context,
                                                          builder: (context) {
                                                            return SizedBox(
                                                              height: 100,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child: Column(
                                                                children: [
                                                                  ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor: const Color
                                                                            .fromRGBO(
                                                                            1,
                                                                            149,
                                                                            247,
                                                                            1)),
                                                                    onPressed:
                                                                        () {
                                                                      context
                                                                          .read<
                                                                              MediaBloc>()
                                                                          .add(
                                                                              UploadPictureFromGalleryEvent());
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      'Upload image from gallery',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                  ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor: const Color
                                                                            .fromRGBO(
                                                                            1,
                                                                            149,
                                                                            247,
                                                                            1)),
                                                                    onPressed:
                                                                        () {
                                                                      context
                                                                          .read<
                                                                              MediaBloc>()
                                                                          .add(
                                                                              UploadPictureFromCameraEvent());
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      'Take a photo',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    )),
                                                TextButton(
                                                  child: const Text(
                                                    'Edit picture or avatar',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          1, 149, 247, 1),
                                                    ),
                                                  ),
                                                  onPressed: () {},
                                                )
                                              ],
                                            ),
                                            const Align(
                                              alignment: Alignment.topLeft,
                                              child: Text('Name'),
                                            ),
                                            TextFieldWidget(
                                                controller: _nameController),
                                            const Align(
                                              alignment: Alignment.topLeft,
                                              child: Text('Username'),
                                            ),
                                            TextFieldWidget(
                                                controller:
                                                    _userNameController),
                                            const Align(
                                              alignment: Alignment.topLeft,
                                              child: Text('Bio'),
                                            ),
                                            TextFieldWidget(
                                                controller: _bioController),
                                            const Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Add link',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(height: Gaps.large),
                                            const Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Switch to professional account',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      1, 149, 247, 1),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: Gaps.large),
                                            const Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Personal information settings',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      1, 149, 247, 1),
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
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {},
                        child: const Text('Share profile'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {},
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
