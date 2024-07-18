import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_entity.dart';
import '../../constants/assets.dart';
import '../../constants/gaps.dart';
import '../../logic/post/post_bloc.dart';
import '../../logic/user/user_bloc.dart';
import '../../widgets/setting_bottom_sheet_widget.dart';
import '../profile/widgets/int_on_string.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.userEntity});
  final UserEntity userEntity;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
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
    var isFollowing = false;

    return BlocConsumer<UserBloc, UserState>(
      listener: (context, userState) {},
      builder: (context, userState) {
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
                  SettingBottomSheetWidget(),
                ],
              ),
              body: Padding(
                padding: EdgeInsets.all(Gaps.large),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              userState.userEntity?.profileImage != null
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
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                                isFollowing
                                    ? Color.fromARGB(255, 102, 100, 100)
                                    : Colors.blue),
                            foregroundColor:
                                WidgetStateProperty.all<Color>(Colors.white),
                          ),
                          // child: const Text(),
                          child: Text(isFollowing
                              ? '       Following       '
                              : '         Follow         '),

                          onPressed: () {
                            setState(() {
                              isFollowing = !isFollowing;
                            });
                            
                          },
                        ),
                        TextButton(
                          style: ButtonStyle(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color.fromARGB(255, 102, 100, 100)),
                            foregroundColor:
                                WidgetStateProperty.all<Color>(Colors.white),
                          ),
                          child: const Text('         Message         '),
                          onPressed: () {},
                        ),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
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
                      child: postState.posts == null || postState.posts!.isEmpty
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
                                              postsList?[index].photoUrl ?? '',
                                          fit: BoxFit.cover,
                                        )
                                      : Text(
                                          'No Posts Yet',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                );
                              },
                            ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
