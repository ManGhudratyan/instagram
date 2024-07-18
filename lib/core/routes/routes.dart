// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/widgets.dart';

import '../../presentation/home/home_page.dart';
import '../../presentation/pages/chats/chats_page.dart';
import '../../presentation/pages/googlelogin/google_login.dart';
import '../../presentation/pages/message/messages_page.dart';
import '../../presentation/pages/posts/create_post_page.dart';
import '../../presentation/pages/profile/profile_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const GoogleLogin(),
    '/home-page': (context) => const HomePage(),
    '/profile-page': (context) => const ProfilePage(),
    '/create-post-page': (context) => const CreatePostPage(),
    '/chat-page': (context) => const ChatsPage(),
    '/messages-page': (context) => const MessagesPage(),
  };
}
