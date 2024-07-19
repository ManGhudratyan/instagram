// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../domain/entities/user_entity.dart';
// import '../../constants/assets.dart';
// import '../../constants/gaps.dart';
// import '../../logic/post/post_bloc.dart';
// import '../../logic/user/user_bloc.dart';
// import '../../widgets/setting_bottom_sheet_widget.dart';
// import '../profile/widgets/int_on_string.dart';

// class UserPage extends StatefulWidget {
//   const UserPage({super.key, required this.userEntity});
//   final UserEntity userEntity;

//   @override
//   State<UserPage> createState() => _UserPageState();
// }

// class _UserPageState extends State<UserPage> {
//   bool isFollowing = false;
//   late String currentUserId;

//   @override
//   void initState() {
//     super.initState();
//     context
//         .read<UserBloc>()
//         .add(GetUserDataEvent(widget.userEntity.userId ?? ''));
//     context.read<PostBloc>().add(GetPostsFromCollectionEvent());

//     _getCurrentUserId();
//   }

//   Future<void> _getCurrentUserId() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       setState(() {
//         currentUserId = user.uid;
//       });

//       final profileUserId = widget.userEntity.userId;
//       if (profileUserId != null) {
//         final userState = context.read<UserBloc>().state;
//         setState(() {
//           isFollowing =
//               userState.userEntity?.followers?.contains(currentUserId) ?? false;
//         });
//       }
//     }
//   }

//   void _toggleFollow() {
//     final profileUserId = widget.userEntity.userId ?? '';
//     if (!isFollowing) {
//       context
//           .read<UserBloc>()
//           .add(RemoveFollowerFromDbEvent(profileUserId, currentUserId));
//     } else {}
//     setState(() {
//       isFollowing = !isFollowing;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<UserBloc, UserState>(
//       listener: (context, userState) {
//         if (userState is UserDataDbUpdated) {
//           setState(() {
//             isFollowing =
//                 userState.userEntity?.followers?.contains(currentUserId) ??
//                     false;
//           });
//         }
//       },
//       builder: (context, userState) {
//         final userEntity = userState.userEntity ?? widget.userEntity;

//         return BlocConsumer<PostBloc, PostState>(
//           listener: (context, postState) {},
//           builder: (context, postState) {
//             final postsList = postState.posts
//                 ?.where((post) => post.userId == userEntity.userId)
//                 .toList();
//             return Scaffold(
//               appBar: AppBar(
//                 automaticallyImplyLeading: false,
//                 title: Text(userEntity.username ?? 'No username'),
//                 actions: const [
//                   SettingBottomSheetWidget(),
//                 ],
//               ),
//               body: Padding(
//                 padding: EdgeInsets.all(Gaps.large),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         CircleAvatar(
//                           radius: 50,
//                           backgroundImage: userEntity.profileImage != null
//                               ? CachedNetworkImageProvider(
//                                   userEntity.profileImage!)
//                               : const AssetImage(Assets.profileImage)
//                                   as ImageProvider,
//                         ),
//                         IntOnString(
//                             count: postsList?.length ?? 0, text: 'Posts'),
//                         IntOnString(
//                             count: userEntity.followers?.length ?? 0,
//                             text: 'Followers'),
//                         IntOnString(
//                             count: userEntity.following?.length ?? 0,
//                             text: 'Following')
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(userEntity.name ?? 'No name'),
//                         Text(userEntity.username ?? 'No username'),
//                         Text(userEntity.bio ?? 'No bio'),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextButton(
//                           style: ButtonStyle(
//                             shape: WidgetStateProperty.all<
//                                 RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                             ),
//                             backgroundColor: WidgetStateProperty.all<Color>(
//                                 isFollowing
//                                     ? const Color.fromARGB(255, 102, 100, 100)
//                                     : Colors.blue),
//                             foregroundColor:
//                                 WidgetStateProperty.all<Color>(Colors.white),
//                           ),
//                           onPressed: _toggleFollow,
//                           child: Text(isFollowing ? 'Following' : 'Follow'),
//                         ),
//                         TextButton(
//                           style: ButtonStyle(
//                             shape: WidgetStateProperty.all<
//                                 RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                             ),
//                             backgroundColor: WidgetStateProperty.all<Color>(
//                                 const Color.fromARGB(255, 102, 100, 100)),
//                             foregroundColor:
//                                 WidgetStateProperty.all<Color>(Colors.white),
//                           ),
//                           child: const Text('Message'),
//                           onPressed: () {},
//                         ),
//                         TextButton(
//                           style: ButtonStyle(
//                               backgroundColor: WidgetStateProperty.all<Color>(
//                                   const Color.fromRGBO(65, 62, 62, 0.612))),
//                           child: const Icon(
//                             Icons.keyboard_arrow_down_outlined,
//                             color: Colors.white,
//                           ),
//                           onPressed: () {},
//                         )
//                       ],
//                     ),
//                     SizedBox(height: Gaps.extraLarge),
//                     const Divider(
//                       color: Colors.grey,
//                     ),
//                     const Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Icon(Icons.grid_on_outlined, size: 30),
//                         Icon(Icons.person_pin_rounded, size: 30)
//                       ],
//                     ),
//                     SizedBox(height: Gaps.large),
//                     Expanded(
//                       child: postState.posts == null || postState.posts!.isEmpty
//                           ? const Center(
//                               child: Text(
//                                 'No posts yet',
//                                 style: TextStyle(color: Colors.red),
//                               ),
//                             )
//                           : GridView.builder(
//                               gridDelegate:
//                                   const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 3,
//                                 mainAxisSpacing: 8,
//                                 crossAxisSpacing: 8,
//                               ),
//                               itemCount: postsList?.length ?? 0,
//                               itemBuilder: (context, index) {
//                                 return SizedBox(
//                                   child: postsList?[index].photoUrl != null
//                                       ? CachedNetworkImage(
//                                           imageUrl: postsList?[index].photoUrl!,
//                                           fit: BoxFit.cover,
//                                         )
//                                       : const Text(
//                                           'No Posts Yet',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                 );
//                               },
//                             ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool isFollowing = false;
  late String currentUserId;

  @override
  void initState() {
    super.initState();
    context
        .read<UserBloc>()
        .add(GetUserDataEvent(widget.userEntity.userId ?? ''));
    context.read<PostBloc>().add(GetPostsFromCollectionEvent());

    _getCurrentUserId();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context
        .read<UserBloc>()
        .add(GetUserDataEvent(widget.userEntity.userId ?? ''));
  }

  Future<void> _getCurrentUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserId = user.uid;
      });

      final profileUserId = widget.userEntity.userId;
      if (profileUserId != null) {
        final userState = context.read<UserBloc>().state;
        setState(() {
          isFollowing =
              userState.userEntity?.followers?.contains(currentUserId) ?? false;
        });
      }
    }
  }

  void _toggleFollow() {
    final profileUserId = widget.userEntity.userId ?? '';
    if (isFollowing) {
      context
          .read<UserBloc>()
          .add(RemoveFollowerFromDbEvent(profileUserId, currentUserId));
    } else {
      context
          .read<UserBloc>()
          .add(AddFollowersToDbEvent(profileUserId, [currentUserId]));
    }
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, userState) {
        if (userState is AddFollowersToDbLoaded) {
          setState(() {
            isFollowing = userState.updatedFollowers.contains(currentUserId);
          });
        }
      },
      builder: (context, userState) {
        final userEntity = userState.userEntity ?? widget.userEntity;

        return BlocConsumer<PostBloc, PostState>(
          listener: (context, postState) {},
          builder: (context, postState) {
            final postsList = postState.posts
                ?.where((post) => post.userId == userEntity.userId)
                .toList();
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(userEntity.username ?? 'No username'),
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
                          onPressed: _toggleFollow,
                          child: Text(isFollowing ? 'Following' : 'Follow'),
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
                          child: const Text('Message'),
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
                                      : const Text(
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
