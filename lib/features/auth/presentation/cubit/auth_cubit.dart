import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  FirebaseAuth auth = FirebaseAuth.instance;

  final _google = GoogleSignIn(
    scopes: ['profile', 'email'],
  );

  Future<void> signInWithGoogle({
    VoidCallback? onError,
  }) async {
    emit(AuthProcessingState());

    try {
      final googleUser = await _google.signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await auth.signInWithCredential(credential).then(
        (value) {
          emit(AuthAuthenticatedState());
        },
      );
    } catch (e, stack) {
      emit(AuthFailedState());
      onError?.call();

      if (!kDebugMode) {
        await FirebaseCrashlytics.instance.recordError(
          e,
          stack,
          reason: 'Auth Failed',
        );
      }

      if (kDebugMode) log(e.toString());
    }
  }
}
