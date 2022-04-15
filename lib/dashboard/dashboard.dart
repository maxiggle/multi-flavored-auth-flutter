import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googlesigninwithflavor/app/bloc/google_sign_in_bloc.dart';
import 'package:googlesigninwithflavor/app/view/google_sign_in_view.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoogleSignInBloc(
        authenticationRepository: RepositoryProvider.of(context),
      ),
      child: DashBoardDetails(),
    );
  }
}

class DashBoardDetails extends StatelessWidget {
  DashBoardDetails({
    Key? key,
  }) : super(key: key);
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GoogleSignInBloc, GoogleSignInState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          Navigator.of(context).pushAndRemoveUntil<Type>(
            MaterialPageRoute(builder: (context) => const GoogleSignInView()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Very Good Codemagic'),
        ),
        body: BlocBuilder<GoogleSignInBloc, GoogleSignInState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text('Welcome to your Dashboard'),
                ),
                Text('${user.displayName}'),
                if (user.photoURL != null)
                  Image.network('${user.photoURL}')
                else
                  Container(),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<GoogleSignInBloc>()
                        .add(GoogleSignOutRequested());
                  },
                  child: const Text('Sign Out'),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
