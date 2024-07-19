import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_entity.dart';
import '../../constants/assets.dart';
import '../../constants/gaps.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/media/media_bloc.dart';
import '../../logic/post/post_bloc.dart';
import '../../logic/user/user_bloc.dart';
import '../../widgets/media_bottom_sheet_widget.dart';
import '../../widgets/setting_bottom_sheet_widget.dart';
import 'widgets/int_on_string.dart';
import 'widgets/text_field_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.userEntity});
  final UserEntity userEntity;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context
        .read<UserBloc>()
        .add(GetUserDataEvent(widget.userEntity.userId ?? ''));
    context.read<PostBloc>().add(GetPostsFromCollectionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, userState) {
        if (userState is SaveUserToDbFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(userState.error ?? '')),
          );
        } else if (userState is SaveUserToDbLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Saving user data...')),
          );
        }
      },
      builder: (context, userState) {
        final nameController =
            TextEditingController(text: userState.userEntity?.name);
        final userNameController =
            TextEditingController(text: userState.userEntity?.username);
        final bioController =
            TextEditingController(text: userState.userEntity?.bio);
        return BlocConsumer<PostBloc, PostState>(
          listener: (context, postState) {},
          builder: (context, postState) {
            final postsList = postState.posts
                ?.where((post) => post.userId == userState.userEntity?.userId)
                .toList();
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(userState.userEntity?.username ?? 'No username'),
                actions: const [
                  MediaBottomSheetWidget(),
                  SettingBottomSheetWidget(),
                ],
              ),
              body: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, authState) {
                  if (authState is SaveUserToDbFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(authState.error ?? '')),
                    );
                  } else if (authState is SaveUserToDbLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Information has updated successfully'),
                      ),
                    );
                    Navigator.pushNamed(context, '/home-page');
                  }
                },
                builder: (context, authState) {
                  return Padding(
                    padding: EdgeInsets.all(Gaps.large),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: userState
                                          .userEntity?.profileImage !=
                                      null
                                  ? CachedNetworkImageProvider(
                                      userState.userEntity?.profileImage ?? '')
                                  : AssetImage(Assets.profileImage),
                            ),
                            IntOnString(
                                count: postsList?.length ?? 0, text: 'Posts'),
                            IntOnString(count: 0, text: 'Followers'),
                            IntOnString(count: 0, text: 'Following')
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userState.userEntity?.name ??
                                'Here need to be your name'),
                            Text(userState.userEntity?.username ??
                                'Here need to be your username'),
                            Text(userState.userEntity?.bio ??
                                'Here need to be your bio'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    const Color.fromARGB(255, 102, 100, 100)),
                                foregroundColor: WidgetStateProperty.all<Color>(
                                    Colors.white),
                              ),
                              child: const Text('    Edit profile    '),
                              onPressed: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return BlocConsumer<MediaBloc, MediaState>(
                                      listener: (context, mediaState) {
                                        if (mediaState is MediaFailed) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text(mediaState.error ?? ''),
                                            ),
                                          );
                                        } else if (mediaState is MediaLoaded) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                  'Media updated successfully'),
                                            ),
                                          );
                                        }
                                      },
                                      builder: (context, mediaState) {
                                        return SingleChildScrollView(
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                50,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.all(Gaps.large),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        AppBar(
                                                          title: const Text(
                                                              'Edit profile'),
                                                          leading: IconButton(
                                                            icon: const Icon(
                                                                Icons.close),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                          actions: [
                                                            IconButton(
                                                              icon: const Icon(
                                                                  Icons.check,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          1,
                                                                          149,
                                                                          247,
                                                                          1)),
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
                                                                  name:
                                                                      nameController
                                                                          .text,
                                                                  bio:
                                                                      bioController
                                                                          .text,
                                                                  username:
                                                                      userNameController
                                                                          .text,
                                                                );
                                                                context
                                                                    .read<
                                                                        UserBloc>()
                                                                    .add(
                                                                      UpdateUserDataEvent(
                                                                          userEntity,
                                                                          file: mediaState
                                                                              .fileImage
                                                                              ?.file),
                                                                    );
                                                                Navigator.pushNamed(
                                                                    context,
                                                                    '/home-page');
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        CircleAvatar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            radius: 50,
                                                            backgroundImage: userState
                                                                        .userEntity
                                                                        ?.profileImage !=
                                                                    null
                                                                ? CachedNetworkImageProvider(
                                                                    userState
                                                                            .userEntity
                                                                            ?.profileImage ??
                                                                        '')
                                                                : AssetImage(Assets
                                                                    .profileImage),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                showModalBottomSheet(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return SizedBox(
                                                                      height:
                                                                          170,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 124, 124, 124)),
                                                                            onPressed:
                                                                                () {
                                                                              context.read<MediaBloc>().add(UploadPictureFromGalleryEvent());
                                                                            },
                                                                            child:
                                                                                const Text(
                                                                              'Upload image from gallery',
                                                                              style: TextStyle(color: Colors.white),
                                                                            ),
                                                                          ),
                                                                          ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 124, 124, 124)),
                                                                            onPressed:
                                                                                () {
                                                                              context.read<MediaBloc>().add(UploadPictureFromCameraEvent());
                                                                            },
                                                                            child:
                                                                                const Text(
                                                                              'Take a photo',
                                                                              style: TextStyle(color: Colors.white),
                                                                            ),
                                                                          ),
                                                                          ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 124, 124, 124)),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                const Text(
                                                                              'Save',
                                                                              style: TextStyle(color: Colors.white),
                                                                            ),
                                                                          ),
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
                                                              color: Color
                                                                  .fromRGBO(
                                                                      1,
                                                                      149,
                                                                      247,
                                                                      1),
                                                            ),
                                                          ),
                                                          onPressed: () {},
                                                        )
                                                      ],
                                                    ),
                                                    const Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text('Name'),
                                                    ),
                                                    TextFieldWidget(
                                                        controller:
                                                            nameController),
                                                    const Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text('Username'),
                                                    ),
                                                    TextFieldWidget(
                                                        controller:
                                                            userNameController),
                                                    const Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text('Bio'),
                                                    ),
                                                    TextFieldWidget(
                                                        controller:
                                                            bioController),
                                                    const Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        'Add link',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: Gaps.large),
                                                    const Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        'Switch to professional account',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              1, 149, 247, 1),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: Gaps.large),
                                                    const Align(
                                                      alignment:
                                                          Alignment.topLeft,
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
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                            TextButton(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    const Color.fromARGB(255, 102, 100, 100)),
                                foregroundColor: WidgetStateProperty.all<Color>(
                                    Colors.white),
                              ),
                              child: const Text('    Share profile    '),
                              onPressed: () {},
                            ),
                            TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      const Color.fromRGBO(65, 62, 62, 0.612))),
                              child: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                        SizedBox(height: Gaps.extraLarge),
                        const Divider(
                          color: Colors.grey,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.grid_on_outlined, size: 30),
                            Icon(Icons.person_pin_rounded, size: 30)
                          ],
                        ),
                        SizedBox(height: Gaps.large),
                        Expanded(
                          child: postState.posts == null ||
                                  postState.posts!.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No posts yet',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                  ),
                                  itemCount: postsList?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      child: postsList?[index].photoUrl != null
                                          ? CachedNetworkImage(
                                              imageUrl:
                                                  postsList?[index].photoUrl ??
                                                      '',
                                              fit: BoxFit.cover,
                                            )
                                          : Text(
                                              'No Posts Yet',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                    );
                                  },
                                ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
