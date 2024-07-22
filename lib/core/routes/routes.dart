// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';
import '../../presentation/pages/chats/chats_page.dart';
import '../../presentation/pages/comment/comment_page.dart';
import '../../presentation/pages/googlelogin/google_login.dart';
import '../../presentation/pages/home/home_page.dart';
import '../../presentation/pages/posts/create_post_page.dart';
import '../../presentation/pages/profile/profile_page.dart';
import '../../presentation/pages/user-chat/user_chat_page.dart';
import '../../presentation/pages/user/user_page.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const GoogleLogin());
      case '/home-page':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/profile-page':
        final userEntity = settings.arguments! as UserEntity;
        return MaterialPageRoute(
            builder: (_) => ProfilePage(userEntity: userEntity));
      case '/user-page':
        final userEntity = settings.arguments! as UserEntity;
        return MaterialPageRoute(
            builder: (_) => UserPage(userEntity: userEntity));
      case '/create-post-page':
        return MaterialPageRoute(builder: (_) => const CreatePostPage());
      case '/chat-page':
        return MaterialPageRoute(builder: (_) => const ChatsPage());
      case '/comments-page':
        return MaterialPageRoute(builder: (_) => const CommentPage());
      case '/user-chat-page':
        final args = settings.arguments! as Map<String, dynamic>;
        final String uid = args['uid'];
        return MaterialPageRoute(builder: (_) => UserChatPage(uid: uid));
      default:
        return null;
    }
  }
}
