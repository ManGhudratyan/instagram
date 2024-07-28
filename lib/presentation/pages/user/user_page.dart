import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/user_entity.dart';
import '../../constants/assets.dart';
import '../../constants/gaps.dart';
import '../../logic/post/post_bloc.dart';
import '../../logic/user/user_bloc.dart';
import '../profile/widgets/int_on_string.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.userEntity});
  final UserEntity userEntity;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isFollowing = false;
  bool hasClickedFollow = false;
  late String currentUserId;

  @override
  void initState() {
    super.initState();
    _getCurrentUserId();
  }

  Future<void> _getCurrentUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserId = user.uid;
      });
      _fetchUserData();
    }
  }

  Future<void> _fetchUserData() async {
    if (widget.userEntity.userId != null && currentUserId.isNotEmpty) {
      context.read<UserBloc>().add(GetUserDataEvent(widget.userEntity.userId!));
      context.read<PostBloc>().add(GetPostsFromCollectionEvent());

      final userState = context.read<UserBloc>().state;
      final isAlreadyFollowing =
          userState.userEntity?.followers?.contains(currentUserId) ?? false;
      setState(() {
        isFollowing = isAlreadyFollowing;
      });
    }
  }

  Future<void> _toggleFollow() async {
    final profileUserId = widget.userEntity.userId ?? '';

    if (profileUserId.isNotEmpty && currentUserId.isNotEmpty) {
      final userState = context.read<UserBloc>().state;
      final isAlreadyFollowing =
          userState.userEntity?.followers?.contains(currentUserId) ?? false;

      if (isFollowing && isAlreadyFollowing) {
        context
            .read<UserBloc>()
            .add(RemoveFollowerFromDbEvent(profileUserId, currentUserId));
        context
            .read<UserBloc>()
            .add(RemoveFollowingFromDbEvent(currentUserId, profileUserId));
      } else if (!isFollowing && !isAlreadyFollowing) {
        context.read<UserBloc>().add(
              AddFollowersToDbEvent(
                profileUserId,
                [currentUserId],
              ),
            );
        context.read<UserBloc>().add(
              AddFollowingsToDbEvent(
                currentUserId,
                [profileUserId],
              ),
            );
      }

      setState(() {
        isFollowing = !isFollowing;
        hasClickedFollow = true;
      });
    }
  }

  Future<void> _copyProfileUrl() async {
    if (widget.userEntity.userId != null) {
      final profileUrl = widget.userEntity.userId;
      await Clipboard.setData(ClipboardData(text: profileUrl ?? ''));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile URL copied to clipboard'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, userState) {
        if (userState is UserDataDbUpdated ||
            userState is AddFollowingsToDbLoaded ||
            userState is RemoveFollowingFromDbLoaded) {
          setState(() {
            isFollowing =
                userState.userEntity?.followers?.contains(currentUserId) ??
                    false;
          });
        }
      },
      builder: (context, userState) {
        final userEntity = userState.userEntity ?? widget.userEntity;
        return BlocConsumer<PostBloc, PostState>(
          listener: (context, postState) {
            if (postState is GetPostFromCollectionFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(postState.error ?? ''),
                ),
              );
            }
          },
          builder: (context, postState) {
            if (postState is GetPostFromCollectionLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final postsList = postState.posts
                ?.where((post) => post.userId == userEntity.userId)
                .toList();

            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.primary,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(userEntity.username ?? 'No username'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.horizontal_split_rounded),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: 350,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: 6,
                                    itemBuilder: (context, index) {
                                      final titles = [
                                        'Report...',
                                        'Block',
                                        'About this account',
                                        'Restrict',
                                        'Hide your story',
                                        'Copy profile URL',
                                      ];

                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text(titles[index]),
                                            onTap: () {
                                              if (titles[index] ==
                                                  'Copy profile URL') {
                                                _copyProfileUrl();
                                              }
                                            },
                                          ),
                                        ],
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
                  )
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
                          backgroundImage: userEntity.profileImage != null
                              ? CachedNetworkImageProvider(
                                  userEntity.profileImage!)
                              : AssetImage(Assets.profileImage)
                                  as ImageProvider,
                        ),
                        IntOnString(
                            count: postsList?.length ?? 0, text: 'Posts'),
                        IntOnString(
                            count: userEntity.followers?.length ?? 0,
                            text: 'Followers'),
                        IntOnString(
                            count: userEntity.followings?.length ?? 0,
                            text: 'Following')
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userEntity.name ?? 'No name'),
                        Text(userEntity.username ?? 'No username'),
                        Text(userEntity.bio ?? 'No bio'),
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
                                    ? const Color.fromARGB(255, 102, 100, 100)
                                    : Colors.blue),
                            foregroundColor:
                                WidgetStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: hasClickedFollow ? null : _toggleFollow,
                          child: Text(isFollowing
                              ? '        Following        '
                              : '       Follow      '),
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
                          child: const Text('        Message      '),
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
                    const Divider(color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.grid_on_outlined,
                            size: 30,
                            color: Theme.of(context).colorScheme.onSurface),
                        Icon(Icons.person_pin_rounded,
                            size: 30,
                            color: Theme.of(context).colorScheme.onSurface)
                      ],
                    ),
                    SizedBox(height: Gaps.large),
                    Expanded(
                      child: postsList == null || postsList.isEmpty
                          ? Center(
                              child: Text('No posts yet',
                                  style: TextStyle(color: Colors.grey)),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                              ),
                              itemCount: postsList.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  child: postsList[index].photoUrl != null
                                      ? CachedNetworkImage(
                                          imageUrl:
                                              postsList[index].photoUrl ?? '',
                                          fit: BoxFit.cover,
                                        )
                                      : const Text(
                                          'No Posts Yet',
                                          style: TextStyle(color: Colors.grey),
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
