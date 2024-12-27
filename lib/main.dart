import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/cubit/user_cubit.dart';
import 'package:my_goals/pages/choose_tab.dart';
import 'package:my_goals/pages/log_in.dart';
import 'package:my_goals/pages/sign_up.dart';

void main() async {
  runApp(
    BlocProvider(
      create: (context) => UserCubit(null),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/signup': (context) => const SignUp(),
          '/login': (context) => const LogIn(),
          '/choosetab': (context) => ChooseTab()
        },
      ),
    ),
  );
}
