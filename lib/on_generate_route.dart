import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/dependency_injection.dart';
import 'package:flutter_firebase/feature/presentation/cubits/auth/auth_cubit.dart';
import 'package:flutter_firebase/feature/presentation/page/home/home_page.dart';

import 'app_constants.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    switch (settings.name) {
      case PageConst.defaultPage:
        return routeBuilder(widget: _home());
      default:
        return routeBuilder(widget: const ErrorPage());
    }
  }
}

MaterialPageRoute routeBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}

Widget _home() {
  return BlocProvider(
    create: (context) => locator<AuthCubit>(),
    child: const HomePage(),
  );
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
    );
  }
}
