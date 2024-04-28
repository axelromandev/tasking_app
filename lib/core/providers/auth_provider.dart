import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as m;

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
          provider: AuthTypeProvider.values[index ?? 0],
        );
      } else {
        _prefs.removeKey(Keys.authProvider);
        state = state.logout();
      }
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
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
          Keys.authProvider, AuthTypeProvider.google.index);
      state = state.copyWith(provider: AuthTypeProvider.google);
      return credential;
    } catch (e) {
      log('$e', name: 'onSignInWithGoogle');
      return null;
    }
  }

  Future<UserCredential?> signInWithApple() async {
    try {
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);
      final webAuthenticationOptions = WebAuthenticationOptions(
        clientId: dotenv.env['APPLE_SERVICE_ID'] ?? '',
        redirectUri: Uri.parse(dotenv.env['APPLE_REDIRECT_URI'] ?? ''),
      );
      UserCredential? credential;
      final apple = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: Platform.isIOS ? nonce : null,
        webAuthenticationOptions:
            Platform.isIOS ? null : webAuthenticationOptions,
      );
      final provider = OAuthProvider('apple.com').credential(
        idToken: apple.identityToken,
        rawNonce: Platform.isIOS ? rawNonce : null,
        accessToken: Platform.isIOS ? null : apple.authorizationCode,
      );
      credential = await FirebaseAuth.instance.signInWithCredential(provider);
      await _prefs.setKeyValue<int>(
          Keys.authProvider, AuthTypeProvider.apple.index);
      state = state.copyWith(provider: AuthTypeProvider.apple);
      return credential;
    } catch (e) {
      log('$e', name: 'onSignInWithApple');
      return null;
    }
  }

  String _generateNonce([int length = 32]) {
    try {
      const charset =
          '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
      final random = m.Random.secure();
      return List.generate(
          length, (_) => charset[random.nextInt(charset.length)]).join();
    } catch (e) {
      throw Exception('Error generateNonce: $e');
    }
  }

  String _sha256ofString(String input) {
    try {
      final bytes = utf8.encode(input);
      final digest = sha256.convert(bytes);
      return digest.toString();
    } catch (e) {
      throw Exception('Error sha256ofString: $e');
    }
  }

  Future<void> logout() async {
    if (state.provider == AuthTypeProvider.google) {
      GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
    }
    await _auth.signOut();
  }
}

class _State {
  final AuthStatus status;
  final AuthTypeProvider provider;
  final User? user;

  _State({
    this.status = AuthStatus.checking,
    this.provider = AuthTypeProvider.unknown,
    this.user,
  });

  _State copyWith({
    AuthStatus? status,
    AuthTypeProvider? provider,
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
      provider: AuthTypeProvider.unknown,
      user: null,
    );
  }
}

enum AuthStatus {
  authenticated,
  unauthenticated,
  checking,
}

enum AuthTypeProvider {
  unknown,
  google,
  apple,
}
