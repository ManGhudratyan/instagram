// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/assets.dart';
import '../logic/user/user_bloc.dart';

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
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          backgroundColor: Colors.blueGrey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Instagram',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: SvgPicture.asset(
                  Assets.rectangleIcon,
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 430,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: ListView.builder(
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  final titles = [
                                    'Reel',
                                    'Post',
                                    'Story',
                                    'Story Highlight',
                                    'Live',
                                    'Guide',
                                  ];
                                  final icons = [
                                    Icons.video_collection_outlined,
                                    Icons.square_outlined,
                                    Icons.add_circle_outline_outlined,
                                    Icons.highlight_outlined,
                                    Icons.leak_remove_outlined,
                                    Icons.menu_book,
                                  ];
                                  return Card(
                                    child: InkWell(
                                      onTap: () {
                                        if(index == 1){
                                        Navigator.pushNamed(context, '/create-post-page');

                                        }
                                      },
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: const Color.fromARGB(255, 194, 201, 207),
                                          child: Icon(icons[index]),
                                        ),
                                        title: Text(titles[index]),
                                      ),
                                    ),
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
              ),
              IconButton(
                icon: SvgPicture.asset(
                  Assets.directIcon,
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: userState.users?.length ?? 0,
            itemBuilder: (context, index) {
              final user = userState.users?[index];
              return Column(
                children: [
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: userState.users?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  userState.users?[index].profileImage ?? Assets.profileImage,
                                ),
                                radius: 40,
                              ),
                              Text(
                                userState.users?[index].name ?? 'No name',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Column(
                    children: [
                      Card(
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.pink,
                          ),
                          title: Text(user?.username ?? 'No username'),
                        ),
                      ),
                      Container(
                        height: 400,
                        decoration: const BoxDecoration(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(Assets.favoriteIcon,
                              color: Colors.white, height: 40),
                          SvgPicture.asset(Assets.commentIcon,
                              color: Colors.white, height: 40),
                          SvgPicture.asset(Assets.vectorIcon,
                              color: Colors.white, height: 28),
                        ],
                      ),
                      SvgPicture.asset(Assets.saveIcon,
                          color: Colors.white, height: 30),
                    ],
                  ),
                ],
              );
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: Colors.black,
                icon: SvgPicture.asset(
                  Assets.homeIcon,
                  color: Colors.white,
                  height: 24,
                  width: 24,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(Assets.groupIcon,
                    color: Colors.white, height: 24, width: 24),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(Assets.movieIcon,
                    color: Colors.white, height: 24, width: 24),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(Assets.favoriteIcon,
                    color: Colors.white, height: 24, width: 24),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile-page');
                  },
                  icon: SvgPicture.asset(
                    Assets.elipseIcon,
                    color: Colors.white,
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
  }
}
