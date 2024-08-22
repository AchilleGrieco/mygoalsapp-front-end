import 'dart:async';

import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/cubit/user_cubit.dart';
import 'package:my_goals/model/user.dart';
import 'package:my_goals/service/authentication_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

   Timer? _timer;

   @override
    void initState() {
    super.initState();
    _scheduleTokenRefresh();
  }

  void _scheduleTokenRefresh() {
    const refreshInterval = Duration(minutes: 30);

    _timer = Timer.periodic(refreshInterval, (timer) async {
      await AuthenticationService().reLogin(context.read<UserCubit>().state!);
    });
  }

    @override
    void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserCubit>().state!;

    return Stack(children: [
      Positioned.fill(
          child: Image.asset(
        'assets/background.jpg',
        fit: BoxFit.fill,
      )),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 40, 50, 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Text(
                      'Home',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Icon(
                      Icons.more_horiz,
                      size: 32,
                      color: Colors.white,
                    )
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar.webp'),
                  maxRadius: 60,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Welcome back',
                  style: TextStyle(fontSize: 26, color: Colors.white),
                ),
                Text(
                  user.username,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 60,
                ),
                const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      
                    ]),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
