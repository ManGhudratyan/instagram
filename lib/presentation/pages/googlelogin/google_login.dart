import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/auth/auth_bloc.dart';

class GoogleLogin extends StatefulWidget {
  const GoogleLogin({super.key});

  @override
  State<GoogleLogin> createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginGoogleFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error ?? ''),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primary,
          appBar: AppBar(
            title: Text('Instagram',
                style: TextStyle(
                  color: Color.fromRGBO(1, 149, 247, 1),
                  fontWeight: FontWeight.bold,
                )),
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          body: Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(1, 149, 247, 1),
              ),
              child: Text(
                'Continue with google',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                context.read<AuthBloc>().add(LoginGoogleEvent());
                Navigator.pushNamed(context, '/home-page');
              },
            ),
          ),
        );
      },
    );
  }
}