import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated._(this.user);

  factory AuthAuthenticated.of(User user) {
    return AuthAuthenticated._(user);
  }

  @override
  List<Object> get props => [];
}

class AuthUnauthenticated extends AuthState {
  final User? user;

  const AuthUnauthenticated._(this.user);

  factory AuthUnauthenticated.of(User? user) {
    return AuthUnauthenticated._(user);
  }

  @override
  List<Object> get props => [];
}

class AuthFailed extends AuthState {
  final String message;

  const AuthFailed._(this.message);

  factory AuthFailed.of(String message) {
    return AuthFailed._(message);
  }

  @override
  List<Object> get props => [];
}
