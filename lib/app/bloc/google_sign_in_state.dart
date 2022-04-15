part of 'google_sign_in_bloc.dart';

abstract class GoogleSignInState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends GoogleSignInState {}

class Authenticated extends GoogleSignInState {}

class Loading extends GoogleSignInState {}
