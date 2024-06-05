import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
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
                const Text(
                  'Achille',
                  style: TextStyle(
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
                        "1",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.cloud,
                        color: Colors.white,
                        size: 50,
                      ),
                    ]),
                const Text(
                  "Days Streak",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
