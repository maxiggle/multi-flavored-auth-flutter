// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googlesigninwithflavor/app/bloc/google_sign_in_bloc.dart';
import 'package:googlesigninwithflavor/app/view/google_sign_in_view.dart';
import 'package:googlesigninwithflavor/repository/authentication_repository.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationRepository(),
      child: BlocProvider(
        create: (context) => GoogleSignInBloc(
          authenticationRepository: RepositoryProvider.of(context),
        ),
        child: MaterialApp(
          theme: ThemeData(
            appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
            colorScheme: ColorScheme.fromSwatch(
              accentColor: const Color(0xFF13B9FF),
            ),
          ),
          home: const GoogleSignInView(),
        ),
      ),
    );
  }
}
