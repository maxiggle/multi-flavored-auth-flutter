import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:googlesigninwithflavor/repository/authentication_repository.dart';

part 'google_sign_in_event.dart';
part 'google_sign_in_state.dart';

class GoogleSignInBloc extends Bloc<GoogleSignInEvent, GoogleSignInState> {
  GoogleSignInBloc({required this.authenticationRepository})
      : super(UnAuthenticated()) {
    on<GoogleSignInRequested>(_onGoogleSignInPressed);
    on<GoogleSignOutRequested>(_onGoogleSignOutPressed);
  }
  final AuthenticationRepository authenticationRepository;

  Future<void> _onGoogleSignInPressed(
    GoogleSignInRequested event,
    Emitter<GoogleSignInState> emit,
  ) async {
    final response = await authenticationRepository.signInWithGoogle();

    if (response) {
      emit(Authenticated());
    }
  }

  void _onGoogleSignOutPressed(
    GoogleSignOutRequested event,
    Emitter<GoogleSignInState> emit,
  ) {
    authenticationRepository.handleSignOut();
    emit(UnAuthenticated());
  }
}
