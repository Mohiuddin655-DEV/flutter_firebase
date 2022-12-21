import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            if (state is AuthFailed){
              final error = state;
              print(error.message);
            }
            return Container(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    cubit.register(email: 'mohiuddin655.bd@gmail.com', password: '123456');
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
