import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'feature/data/remote/data_source_impls/firebase_remote_data_source_impl.dart';
import 'feature/data/remote/data_sources/firebase_remote_data_source.dart';
import 'feature/data/remote/repository_impls/firebase_repository_impl.dart';
import 'feature/domain/repositories/firebase_repository.dart';
import 'feature/domain/use_cases/create_user_usecase.dart';
import 'feature/domain/use_cases/get_uid_usecase.dart';
import 'feature/domain/use_cases/is_sign_in_usecase.dart';
import 'feature/domain/use_cases/sign_in_usecase.dart';
import 'feature/domain/use_cases/sign_out_usecase.dart';
import 'feature/domain/use_cases/sign_up_usecase.dart';
import 'feature/presentation/cubits/auth/auth_cubit.dart';

GetIt locator = GetIt.instance;

Future<void> init() async {
  // Cubit/Bloc
  locator.registerFactory<AuthCubit>(() => AuthCubit(
        signInUseCase: locator(),
        isSignInUseCase: locator(),
        signUpUseCase: locator(),
        signOutUseCase: locator(),
        createUserUseCase: locator(),
      ));

  // Use Case
  locator.registerLazySingleton<CreateUserUseCase>(
      () => CreateUserUseCase(repository: locator.call()));
  locator.registerLazySingleton<GetUidUseCase>(
      () => GetUidUseCase(repository: locator.call()));
  locator.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: locator.call()));
  locator.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: locator.call()));
  locator.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: locator.call()));
  locator.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: locator.call()));

  // Repository
  locator.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(source: locator.call()));

  //Data Source
  locator.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(
          auth: locator.call(), firestore: locator.call()));

  //External
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  locator.registerLazySingleton(() => auth);
  locator.registerLazySingleton(() => firestore);
}
