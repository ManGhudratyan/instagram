// ignore_for_file: prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/assets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: () {},
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
      body: Column(
        children: [
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.pink,
                        radius: 40,
                      ),
                      Text('Username'),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(),
          Column(
            children: [
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.pink,
                  ),
                  title: Text('Username'),
                ),
              ),
              Container(
                height: 400,
                decoration: BoxDecoration(color: Colors.white),
              )
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
  }
}
