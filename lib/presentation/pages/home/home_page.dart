// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../domain/entities/user_entity.dart';
import '../../constants/assets.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/post/post_bloc.dart';
import '../../logic/user/user_bloc.dart';
import '../../widgets/media_bottom_sheet_widget.dart';
import '../user/user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUsersCollectionEvent());
    context.read<PostBloc>().add(GetPostsFromCollectionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, userState) {
        if (userState is GetUsersFromCollectionFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(userState.error ?? 'Failed to load users'),
            ),
          );
        }
      },
      builder: (context, userState) {
        if (userState is GetUsersFromCollectionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return BlocConsumer<AuthBloc, AuthState>(
          listener: (context, authState) {
            if (authState is PostFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(authState.error ?? ''),
                ),
              );
            }
          },
          builder: (context, authState) {
            if (authState is LoginGoogleLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final currentUserId = authState.userCredential?.user?.uid;

            final filteredUsers = userState.users
                    ?.where((user) => user.userId != currentUserId)
                    .map((user) => user.toModel())
                    .toList() ??
                [];
            return BlocConsumer<PostBloc, PostState>(
              listener: (context, postState) {
                if (postState is PostFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(postState.error ?? ''),
                    ),
                  );
                }
              },
              builder: (context, postState) {
                if (postState is PostLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Scaffold(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    title: Text(
                      'Instagram',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    actions: [
                      const MediaBottomSheetWidget(),
                      IconButton(
                        icon: SvgPicture.asset(
                          Assets.messengerIcon,
                          height: 24,
                          width: 24,
                          color: const Color.fromARGB(255, 113, 113, 113),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/chat-page');
                        },
                      ),
                    ],
                  ),
                  body: Column(
                    children: [
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: filteredUsers.length,
                          itemBuilder: (context, index) {
                            if (index >= (filteredUsers.length)) {
                              return Container();
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        final user = filteredUsers[index];
                                        if (user != null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UserPage(
                                                userEntity: user,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        backgroundImage:
                                            filteredUsers[index].profileImage !=
                                                    null
                                                ? CachedNetworkImageProvider(
                                                    filteredUsers[index]
                                                            .profileImage ??
                                                        '')
                                                : null,
                                        radius: 40,
                                        child:
                                            filteredUsers[index].profileImage ==
                                                    null
                                                ? Text(
                                                    filteredUsers[index]
                                                            .username
                                                            ?.substring(0, 1)
                                                            .toUpperCase() ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 40,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary),
                                                  )
                                                : null,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    filteredUsers[index].name ??
                                        authState.userCredential?.user
                                            ?.displayName ??
                                        '',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const Divider(),
                      Expanded(
                        child: postState.posts == null ||
                                postState.posts!.isEmpty
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                itemCount: postState.posts?.length ?? 0,
                                itemBuilder: (context, index) {
                                  if (index >= (postState.posts?.length ?? 0)) {
                                    return Container();
                                  }
                                  final user = userState.users?.firstWhere(
                                    (user) =>
                                        user.userId ==
                                        postState.posts?[index].userId,
                                  );
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        child: ListTile(
                                          tileColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          leading: CircleAvatar(
                                            backgroundImage: user
                                                        ?.profileImage !=
                                                    null
                                                ? CachedNetworkImageProvider(
                                                    user?.profileImage ?? '')
                                                : null,
                                            radius: 30,
                                            child: user?.profileImage == null
                                                ? Text(
                                                    user?.username
                                                            ?.substring(0, 1)
                                                            .toUpperCase() ??
                                                        '',
                                                    style: const TextStyle(
                                                        fontSize: 40),
                                                  )
                                                : null,
                                          ),
                                          title: Text(
                                            user?.name ?? 'No username',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface),
                                          ),
                                          trailing: user?.userId ==
                                                  currentUserId
                                              ? IconButton(
                                                  icon:
                                                      Icon(Icons.delete_sharp),
                                                  onPressed: () {
                                                    final postId = postState
                                                            .posts?[index]
                                                            .postId ??
                                                        '';
                                                    if (postId.isNotEmpty) {
                                                      context
                                                          .read<PostBloc>()
                                                          .add(
                                                            DeletePostDataEvent(
                                                                postId),
                                                          );
                                                    }
                                                  },
                                                )
                                              : null,
                                        ),
                                      ),
                                      Center(
                                        child: SizedBox(
                                          height: 400,
                                          child: postState
                                                      .posts?[index].photoUrl !=
                                                  null
                                              ? CachedNetworkImage(
                                                  imageUrl: postState
                                                      .posts![index].photoUrl!)
                                              : null,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(Assets.heartIcon,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                  height: 40),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(context,
                                                      '/comments-page');
                                                },
                                                child: SvgPicture.asset(
                                                  Assets.commentIcon,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                  height: 40,
                                                ),
                                              ),
                                              SvgPicture.asset(
                                                  Assets.vectorIcon,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                  height: 28),
                                            ],
                                          ),
                                          SvgPicture.asset(Assets.saveIcon,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                              height: 30),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, bottom: 10.0),
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Description ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              postState.posts?[index]
                                                      .description ??
                                                  'No description',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        icon: SvgPicture.asset(
                          Assets.homeIcon,
                          color: Color.fromARGB(255, 69, 74, 86),
                          height: 24,
                          width: 24,
                        ),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(Assets.groupIcon,
                            color: Color.fromARGB(255, 69, 74, 86),
                            height: 24,
                            width: 24),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(Assets.movieIcon,
                            color: Color.fromARGB(255, 69, 74, 86),
                            height: 24,
                            width: 24),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(Assets.heartIcon,
                            color: Color.fromARGB(255, 69, 74, 86),
                            height: 24,
                            width: 24),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: IconButton(
                          onPressed: () {
                            final userId = context
                                .read<AuthBloc>()
                                .state
                                .userCredential
                                ?.user
                                ?.uid;
                            if (userId != null) {
                              context
                                  .read<UserBloc>()
                                  .add(GetUserDataEvent(userId));
                              Navigator.pushNamed(context, '/profile-page',
                                  arguments: UserEntity());
                            }
                          },
                          icon: SvgPicture.asset(
                            Assets.elipseIcon,
                            color: Color.fromARGB(255, 69, 74, 86),
                            height: 24,
                            width: 24,
                          ),
                        ),
                        label: '',
                      ),
                    ],
                    selectedItemColor: Colors.amber[800],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
