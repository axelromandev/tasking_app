import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../config/const/constants.dart';
import '../core.dart';

final authProvider = StateNotifierProvider<_Notifier, _State>((ref) {
  return _Notifier();
});

class _Notifier extends StateNotifier<_State> {
  _Notifier() : super(_State()) {
    _checkAuthStatus();
  }

  final _auth = FirebaseAuth.instance;
  final _prefs = SharedPrefs();

  void _checkAuthStatus() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        final index = _prefs.getValue<int>(Keys.authProvider);
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
          provider: AuthProvider.values[index ?? 0],
        );
      } else {
        _prefs.removeKey(Keys.authProvider);
        state = state.logout();
      }
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    try {
      final google = await googleSignIn.signIn();
      if (google == null) return null;
      final googleAuth = await google.authentication;
      final credential = await FirebaseAuth.instance.signInWithCredential(
        GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        ),
      );
      await _prefs.setKeyValue<int>(
          Keys.authProvider, AuthProvider.google.index);
      state = state.copyWith(provider: AuthProvider.google);
      return credential;
    } catch (e) {
      log('$e', name: 'onSignInWithGoogle');
      return null;
    }
  }

  Future<UserCredential?> signInWithApple() async {
    try {
      UserCredential? credential;
      if (Platform.isAndroid) {
        credential = await FirebaseAuth.instance.signInWithProvider(
          AppleAuthProvider(),
        );
      } else {
        final apple = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
        credential = await FirebaseAuth.instance.signInWithCredential(
          OAuthProvider('apple.com').credential(
            idToken: apple.identityToken,
            accessToken: apple.authorizationCode,
          ),
        );
      }
      await _prefs.setKeyValue<int>(
          Keys.authProvider, AuthProvider.apple.index);
      state = state.copyWith(provider: AuthProvider.apple);
      return credential;
    } catch (e) {
      log('$e', name: 'onSignInWithApple');
      return null;
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
