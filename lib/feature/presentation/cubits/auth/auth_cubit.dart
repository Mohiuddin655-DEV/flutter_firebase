import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/feature/domain/entities/user_entity.dart';

import '../../../domain/use_cases/create_user_usecase.dart';
import '../../../domain/use_cases/is_sign_in_usecase.dart';
import '../../../domain/use_cases/sign_in_usecase.dart';
import '../../../domain/use_cases/sign_out_usecase.dart';
import '../../../domain/use_cases/sign_up_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUseCase isSignInUseCase;
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final CreateUserUseCase createUserUseCase;

  AuthCubit({
    required this.isSignInUseCase,
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.createUserUseCase,
  }) : super(AuthInitial());

  Future<void> isLoggedIn() async {
    final result = await isSignInUseCase.call();
    if (result) emit(state);
  }

  Future<void> register({String? email, String? password}) async {
    if (email != null && password != null) {
      try {
        final result =
            await signUpUseCase.call(email: email, password: password);
        final user = result.user;
        if (user != null) {
          emit(AuthAuthenticated.of(user));
        } else {
          emit(AuthFailed.of('Authenticated failed!'));
        }
      } catch (e) {
        emit(AuthFailed.of(e.toString()));
      }
    } else {
      emit(AuthFailed.of('Input not valid!'));
    }
  }

  Future<void> login({String? email, String? password}) async {
    if (email != null && password != null) {
      final result = await signInUseCase.call(email: email, password: password);
      final user = result.user;
      if (user != null) {
        emit(AuthAuthenticated.of(user));
      } else {
        emit(AuthFailed.of('Authenticated failed!'));
      }
    } else {
      emit(AuthFailed.of('Input not valid!'));
    }
  }

  Future<void> logout() async {
    await signOutUseCase.call();
    if (state is AuthAuthenticated) {
      AuthAuthenticated oldState = state as AuthAuthenticated;
      emit(AuthUnauthenticated.of(oldState.user));
    } else {
      emit(AuthUnauthenticated.of(null));
    }
  }

  Future<void> createUser(UserEntity user) async {
    await createUserUseCase.call(user);
    if (state is AuthAuthenticated) {
      AuthAuthenticated oldState = state as AuthAuthenticated;
      emit(AuthUnauthenticated.of(oldState.user));
    } else {
      emit(AuthUnauthenticated.of(null));
    }
  }
}
