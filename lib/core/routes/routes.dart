// // ignore_for_file: avoid_classes_with_only_static_members, cast_nullable_to_non_nullable

// import 'package:flutter/widgets.dart';

// import '../../domain/entities/user_entity.dart';
// import '../../presentation/pages/chat/chat_pagee.dart';
// import '../../presentation/pages/chats/chats_page.dart';
// import '../../presentation/pages/comment/comment_page.dart';
// import '../../presentation/pages/googlelogin/google_login.dart';
// import '../../presentation/pages/home/home_page.dart';
// import '../../presentation/pages/message/messages_page.dart';
// import '../../presentation/pages/posts/create_post_page.dart';
// import '../../presentation/pages/profile/profile_page.dart';
// import '../../presentation/pages/user/user_page.dart';

// class Routes {
//   static Map<String, Widget Function(BuildContext)> routes = {
//     '/': (context) => const GoogleLogin(),
//     '/home-page': (context) => const HomePage(),
//     '/profile-page': (context) => ProfilePage(
//           userEntity: ModalRoute.of(context)?.settings.arguments as UserEntity,
//         ),
//     '/user-page': (context) => UserPage(
//           userEntity: ModalRoute.of(context)!.settings.arguments as UserEntity,
//         ),
//     '/create-post-page': (context) => const CreatePostPage(),
//     '/chat-page': (context) => const ChatsPage(),
//     '/messages-page': (context) => const MessagesPage(),
//     '/comments-page': (context) => const CommentPage(),
//     '/chat-pagee': (context) => const ChatPagee(),
//   };
// }

// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';
import '../../presentation/pages/chat/chat_pagee.dart';
import '../../presentation/pages/chats/chats_page.dart';
import '../../presentation/pages/comment/comment_page.dart';
import '../../presentation/pages/googlelogin/google_login.dart';
import '../../presentation/pages/home/home_page.dart';
import '../../presentation/pages/message/messages_page.dart';
import '../../presentation/pages/posts/create_post_page.dart';
import '../../presentation/pages/profile/profile_page.dart';
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
      case '/messages-page':
        return MaterialPageRoute(builder: (_) => const MessagesPage());
      case '/comments-page':
        return MaterialPageRoute(builder: (_) => const CommentPage());
      case '/chat-pagee':
        final args = settings.arguments! as Map<String, dynamic>;
        final String uid = args['uid'];
        return MaterialPageRoute(builder: (_) => ChatPagee(uid: uid));
      default:
        return null;
    }
  }
}
