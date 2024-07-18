import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/user/user_bloc.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUsersCollectionEvent());
  }

  @override
  Widget build(BuildContext context) {
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
        return Scaffold(
          appBar: AppBar(
            title: Text(userState.userEntity?.username ?? 'No username'),
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
                    itemCount: userState.users?.length ?? 0,
                    itemBuilder: (context, index) {
                      final usersList = userState.users
                          ?.where(
                            (element) =>
                                element.userId != userState.userEntity?.userId,
                          )
                          .toList();

                      final currentUser = usersList?[index];
                      if (currentUser == null) return SizedBox.shrink();

                      return GestureDetector(
                        onTap: () {},
                        child: ListTile(
                          subtitle: Text('Sent just now'),
                          title: Text(currentUser.name ?? ''),
                          trailing: Icon(Icons.camera_alt),
                          leading: CircleAvatar(
                            backgroundImage: currentUser.profileImage != null
                                ? CachedNetworkImageProvider(
                                    currentUser.profileImage!,
                                  )
                                : null,
                            radius: 40,
                            child: currentUser.profileImage == null
                                ? Text(
                                    currentUser.username
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
  }
}
