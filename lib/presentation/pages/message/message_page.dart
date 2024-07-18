import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/user/user_bloc.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});
  // final user = FirebaseAuth.instance.currentUser;

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
            SnackBar(
              content: Text('Fail to get users'),
            ),
          );
        }
      },
      builder: (context, userState) {
        return Scaffold(
          appBar: AppBar(
              // title: Text(userState.userEntity.username),
              ),
          body: ListView.builder(
            itemCount: userState.users?.length ?? 0,
            itemBuilder: (context, index) {
              final usersList = userState.users
                  ?.where(
                    (element) => element.userId != userState.userEntity?.userId,
                  )
                  .toList();

              return GestureDetector(
                onTap: () {},
                child: ListTile(
                  title: Text(usersList?[index].name ?? ''),
                  leading: CircleAvatar(
                    backgroundImage: usersList?[index].profileImage != null
                        ? NetworkImage(usersList?[index].profileImage! ?? '')
                        : null,
                    radius: 40,
                    child: usersList?[index].profileImage == null
                        ? Text(
                            usersList?[index]
                                    .username
                                    ?.substring(0, 1)
                                    .toUpperCase() ??
                                '',
                            style: TextStyle(fontSize: 40),
                          )
                        : null,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Widget _chatsList() {
  //   return StreamBuilder(
  //     stream: widget.userServiceImp?.getUsersFromCollection(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) {
  //         return const Center(
  //           child: Text('Unable to load data'),
  //         );
  //       }
  //       if (snapshot.hasData && snapshot.data != null) {
  //         final users = snapshot.data!.docs;
  //         return ListView.builder(
  //           itemCount: users.length,
  //           itemBuilder: (context, index) {

  //           },
  //         );
  //       }
  //       return const Center(
  //         child: CircularProgressIndicator(),
  //       );
  //     },
  //   );
  // }
}
