// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/widgets.dart';

import '../../presentation/home/home_page.dart';
import '../../presentation/pages/googlelogin/google_login.dart';
import '../../presentation/pages/message/message_page.dart';
import '../../presentation/pages/posts/create_post_page.dart';
import '../../presentation/pages/profile/profile_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => GoogleLogin(),
    '/home-page': (context) => HomePage(),
    '/profile-page': (context) => ProfilePage(),
    '/create-post-page': (context) => CreatePostPage(),
    '/message-page': (context) => MessagePage(),
  };
}
