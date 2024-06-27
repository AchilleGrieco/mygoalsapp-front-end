import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:my_goals/pages/choose_tab.dart';
import 'package:my_goals/pages/log_in.dart';
import 'package:my_goals/pages/sign_up.dart';

void main() async {
  runApp(
    MaterialApp(
      initialRoute: '/login',
      routes: {
        '/signup': (context) => const SignUp(),
        '/login': (context) => const LogIn(),
        '/choosetab': (context) => const ChooseTab()
      },
    ),
  );
}
