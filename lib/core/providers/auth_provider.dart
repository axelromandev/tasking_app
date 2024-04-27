import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

final authProvider = StateNotifierProvider<_Notifier, _State>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<_State> {
  _Notifier() : super(_State()) {
    _checkAuthStatus();
  }

  final _auth = FirebaseAuth.instance;

  void _checkAuthStatus() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        state = state.copyWith(status: AuthStatus.authenticated, user: user);
      } else {
        state = state.logout();
      }
    });
  }

  Future<void> onSignInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    try {
      final google = await googleSignIn.signIn();
      if (google == null) return;
      final googleAuth = await google.authentication;
      await FirebaseAuth.instance.signInWithCredential(
        GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        ),
      );
      state = state.copyWith(provider: AuthProvider.google);
    } catch (e) {
      log('$e', name: 'onSignInWithGoogle');
    }
  }

  Future<void> onSignInWithApple() async {
    try {
      if (Platform.isAndroid) {
        await FirebaseAuth.instance.signInWithProvider(
          AppleAuthProvider(),
        );
      } else {
        final apple = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
        await FirebaseAuth.instance.signInWithCredential(
          OAuthProvider('apple.com').credential(
            idToken: apple.identityToken,
            accessToken: apple.authorizationCode,
          ),
        );
      }
      state = state.copyWith(provider: AuthProvider.apple);
    } catch (e) {
      log('$e', name: 'onSignInWithApple');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}

class _State {
  final AuthStatus status;
  final AuthProvider provider;
  final User? user;

  _State({
    this.status = AuthStatus.checking,
    this.provider = AuthProvider.unknown,
    this.user,
  });

  _State copyWith({
    AuthStatus? status,
    AuthProvider? provider,
    User? user,
  }) {
    return _State(
      status: status ?? this.status,
      provider: provider ?? this.provider,
      user: user ?? this.user,
    );
  }

  _State logout() {
    return _State(
      status: AuthStatus.unauthenticated,
      provider: AuthProvider.unknown,
      user: null,
    );
  }
}

enum AuthStatus {
  authenticated,
  unauthenticated,
  checking,
}

enum AuthProvider {
  unknown,
  google,
  apple,
}
