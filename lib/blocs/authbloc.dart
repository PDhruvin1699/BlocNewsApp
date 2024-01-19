// import 'package:blocnewsdemo/blocs/autstat.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   AuthBloc(super.initialState);
//
//   @override
//   AuthState get initialState => AuthInitial();
//
//   @override
//   Stream<AuthState> mapEventToState(AuthEvent event) async* {
//     if (event is SignupEvent) {
//       yield* _mapSignupEventToState(event);
//     } else if (event is LoginEvent) {
//       yield* _mapLoginEventToState(event);
//     }
//   }
//
//   Stream<AuthState> _mapSignupEventToState(SignupEvent event) async* {
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: event.email,
//         password: event.password,
//       );
//       // You can add additional logic here if needed
//       yield SignupSuccess();
//     } catch (e) {
//       yield SignupFailure(error: e.toString());
//     }
//   }
//
//   Stream<AuthState> _mapLoginEventToState(LoginEvent event) async* {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: event.email,
//         password: event.password,
//       );
//       // You can add additional logic here if needed
//       yield LoginSuccess(user: userCredential.user);
//     } catch (e) {
//       yield LoginFailure(error: e.toString());
//     }
//   }
// }
// class AuthEvent {}
//
// class AuthState {}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'autstat.dart';
// auth_cubit.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'autstat.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit() : super(AuthInitial());

  // Future<void> signUp({required String email, required String password}) async {
  //   try {
  //     await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     emit(AuthSuccess());
  //   } catch (e) {
  //     emit(AuthError(e.toString()));
  //   }
  // }
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthSuccess());
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
        // Handle the case where the email is already in use
        emit(AuthError('Email is already in use. Please sign in.'));
      } else {
        // Handle other errors
        emit(AuthError(e.toString()));
      }
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> checkAuthStatus() async {
    // Your authentication status check logic here
    // Example: bool isAuthenticated = await authService.checkAuthStatus();

    if (isAuthenticated) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }
  Future<void> reauthenticate({required String email}) async {
    try {
      // Check if there is a user signed in
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        // If no user is currently signed in, emit AuthAuthenticated
        emit(AuthAuthenticated());
        return;
      }

      // Check if the entered email matches the signed-in user's email
      if (currentUser.email == email) {
        // Proceed with the reauthentication process
        // You may need to implement the specific reauthentication logic based on your authentication provider
        // Example: await currentUser.reauthenticateWithCredential(credential);

        // After successful reauthentication, emit AuthAuthenticated
        emit(AuthAuthenticated());
      } else {
        // Handle the case where the entered email does not match the signed-in user's email
        emit(AuthError('Entered email does not match the signed-in user\'s email.'));
      }
    } catch (e) {
      // Handle other errors during reauthentication
      emit(AuthError(e.toString()));
    }
  }



  Future<void> signOut() async {
    await _auth.signOut();
    emit(AuthInitial());
  }

  bool get isAuthenticated => _auth.currentUser != null;
}

