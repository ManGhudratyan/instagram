import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/user/user_bloc.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUsersCollectionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, authState) {
        // TODO: implement listener
      },
      builder: (context, authState) {
        return BlocConsumer<UserBloc, UserState>(
          listener: (context, userState) {
            if (userState is GetUsersFromCollectionFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to get users'),
                ),
              );
            }
          },
          builder: (context, userState) {
            final usersList = userState.users
                ?.where(
                  (element) => element.userId != userState.userEntity?.userId,
                )
                .toList();

            return Scaffold(
              appBar: AppBar(
                title: Text(authState.userCredential?.user?.displayName ?? ''),
                actions: const [
                  Icon(Icons.video_camera_back),
                  Icon(Icons.add),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Messages',
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: usersList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/messages-page');
                            },
                            child: ListTile(
                              title: Text(usersList?[index].name ?? ''),
                              subtitle: Text('Sent just now'),
                              trailing: Icon(Icons.camera_alt),
                              leading: CircleAvatar(
                                backgroundImage:
                                    usersList?[index].profileImage != null
                                        ? CachedNetworkImageProvider(
                                            usersList?[index].profileImage ??
                                                '',
                                          )
                                        : null,
                                radius: 40,
                                child: usersList?[index].profileImage == null
                                    ? Text(
                                        usersList?[index]
                                                .username
                                                ?.substring(0, 1)
                                                .toUpperCase() ??
                                            '',
                                        style: const TextStyle(fontSize: 40),
                                      )
                                    : null,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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
