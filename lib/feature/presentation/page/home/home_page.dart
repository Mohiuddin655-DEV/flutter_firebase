import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_firebase/feature/presentation/cubits/auth/auth_cubit.dart';
import 'package:flutter_firebase/feature/presentation/cubits/auth/auth_state.dart';

import '../../../../dependency_injection.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<AuthCubit>(),
      child: Scaffold(
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final cubit = context.read<AuthCubit>();
            if (state is AuthFailed) {
              final error = state;
              print(error.message);
            }
            return Container(
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    _facebookSignIn();
                    // FacebookAuth.instance.login(
                    //   permissions: ['public_profile', 'email'],
                    // ).then((value) {
                    //   FacebookAuth.instance
                    //       .getUserData()
                    //       .then((userData) async {
                    //     print(userData);
                    //   });
                    // });
                    //cubit.register(email: 'mohiuddin655.bd@gmail.com', password: '123456');
                  },
                  child: Text('login'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Future<void> _facebookSignIn() async {
  try {
    final result =
        await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.i.getUserData();
      print(userData);
    }
  } catch (error) {
    print(error);
  }
}
