import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
        );
      } else {
        state = state.copyWith(status: AuthStatus.unauthenticated);
      }
    });
  }
}

class _State {
  final AuthStatus status;
  final User? user;

  _State({
    this.status = AuthStatus.checking,
    this.user,
  });

  _State copyWith({
    AuthStatus? status,
    User? user,
  }) {
    return _State(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}

enum AuthStatus {
  authenticated,
  unauthenticated,
  checking,
}
