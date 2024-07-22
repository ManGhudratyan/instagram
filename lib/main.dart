import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_themes/app_theme.dart';
import 'core/routes/routes.dart';
import 'data/repositories/auth/auth_repository_imp.dart';
import 'data/repositories/chat/chat_repository_imp.dart';
import 'data/repositories/comment/comment_repository_imp.dart';
import 'data/repositories/media/media_repository_imp.dart';
import 'data/repositories/post/post_repository_imp.dart';
import 'data/repositories/user/user_repository_imp.dart';
import 'data/services/auth/auth_service.dart';
import 'data/services/auth/auth_service_imp.dart';
import 'data/services/chat/chat_service.dart';
import 'data/services/chat/chat_service_imp.dart';
import 'data/services/comments/comments_service.dart';
import 'data/services/comments/comments_service_imp.dart';
import 'data/services/media/media_service.dart';
import 'data/services/media/media_service_imp.dart';
import 'data/services/post/post_service.dart';
import 'data/services/post/post_service_imp.dart';
import 'data/services/user/user_service.dart';
import 'data/services/user/user_service_imp.dart';
import 'domain/repositories/auth/auth_repository.dart';
import 'domain/repositories/chat/chat_repository.dart';
import 'domain/repositories/comment/comment_repository.dart';
import 'domain/repositories/media/media_repository.dart';
import 'domain/repositories/post/post_repository.dart';
import 'domain/repositories/user/user_repository.dart';
import 'presentation/logic/auth/auth_bloc.dart';
import 'presentation/logic/chat/chat_bloc.dart';
import 'presentation/logic/cubit/theme_cubit.dart';
import 'presentation/logic/media/media_bloc.dart';
import 'presentation/logic/post/post_bloc.dart';
import 'presentation/logic/user/user_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyBuAs7ySEpbAmuvNf1t5bOAPtpLpeO3qUc',
        appId: '1:769958999795:android:3e8f61d31ae93e3ba4e986',
        messagingSenderId: '',
        projectId: 'instagram-flutter-fecce',
        storageBucket: 'gs://instagram-flutter-fecce.appspot.com',
        databaseURL:
            'https://instagram-flutter-fecce-default-rtdb.firebaseio.com/'),
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthService>(
          create: (context) =>
              AuthServiceImp(firebaseFirestore: FirebaseFirestore.instance),
        ),
        RepositoryProvider<UserService>(
          create: (context) => UserServiceImp(
            FirebaseFirestore.instance,
            FirebaseStorage.instance,
            FirebaseAuth.instance,
          ),
        ),
        RepositoryProvider<MediaService>(
          create: (context) => MediaServiceImp(),
        ),
        RepositoryProvider<ChatService>(
          create: (context) => ChatServiceImp(),
        ),
        RepositoryProvider<CommentsService>(
          create: (context) => CommentsServiceImp(
            firebaseDatabase: FirebaseDatabase.instance,
            firebaseStorage: FirebaseStorage.instance,
          ),
        ),
        RepositoryProvider<PostService>(
          create: (context) => PostServiceImp(
            firebaseDatabase: FirebaseDatabase.instance,
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseStorage: FirebaseStorage.instance,
          ),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) =>
              AuthRepositoryImp(RepositoryProvider.of<AuthService>(context)),
        ),
        RepositoryProvider<ChatRepository>(
          create: (context) =>
              ChatRepositoryImp(RepositoryProvider.of<ChatService>(context)),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) =>
              UserRepositoryImp(RepositoryProvider.of<UserService>(context)),
        ),
        RepositoryProvider<MediaRepository>(
          create: (context) =>
              MediaRepositoryImp(RepositoryProvider.of<MediaService>(context)),
        ),
        RepositoryProvider<PostRepository>(
          create: (context) => PostRepositoryImp(
              postService: RepositoryProvider.of<PostService>(context)),
        ),
        RepositoryProvider<CommentRepository>(
          create: (context) => CommentRepositoryImp(
              RepositoryProvider.of<CommentsService>(context)),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthBloc(RepositoryProvider.of<AuthRepository>(context)),
          ),
          BlocProvider(
            create: (context) => ThemeCubit(),
          ),
          BlocProvider(
            create: (context) =>
                UserBloc(RepositoryProvider.of<UserRepository>(context)),
          ),
          BlocProvider(
            create: (context) =>
                MediaBloc(RepositoryProvider.of<MediaRepository>(context)),
          ),
          BlocProvider(
            create: (context) =>
                PostBloc(RepositoryProvider.of<PostRepository>(context)),
          ),
          BlocProvider(
            create: (context) =>
                ChatBloc(RepositoryProvider.of<ChatRepository>(context)),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              // routes: Routes.routes,
              onGenerateRoute: Routes.generateRoute,
              initialRoute: '/',
              themeMode: state.themeMode,
              theme: AppThemeData(context: context).lighTheme,
              darkTheme: AppThemeData(context: context).darkTheme,
            );
          },
        ),
      ),
    ),
  );
}
