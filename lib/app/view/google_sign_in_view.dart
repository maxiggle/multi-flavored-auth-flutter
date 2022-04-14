import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googlesigninwithflavor/app/bloc/google_sign_in_bloc.dart';
import 'package:googlesigninwithflavor/dashboard/dashboard.dart';
import 'package:googlesigninwithflavor/repository/authentication_repository.dart';


class GoogleSignInView extends StatelessWidget {
  const GoogleSignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationRepository(),
      child: BlocProvider(
        create: (context) => GoogleSignInBloc(
          authenticationRepository: RepositoryProvider.of(context),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Sign In With Google'),
          ),
          body: const ShowSignInButton(),
        ),
      ),
    );
  }
}

class ShowSignInButton extends StatelessWidget {
  const ShowSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<GoogleSignInBloc, GoogleSignInState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.push<Type>(
            context,
            MaterialPageRoute(builder: (_) => const DashBoard()),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'asset/google2.png',
              height: 60,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<GoogleSignInBloc>().add(GoogleSignInRequested());
            },
            child: const Text('Sign In With Google'),
          ),
        ],
      ),
    );
  }
}
