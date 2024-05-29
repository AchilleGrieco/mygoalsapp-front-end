import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({super.key, required this.name, required this.icon});

  final String name;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
        child: Row(children: [
          const Icon(
            Icons.run_circle,
            size: 58,
          ),
          const SizedBox(
            width: 30,
          ),
          const Text(
            "Running",
            style: TextStyle(fontSize: 24),
          ),
          //expanded
          const Expanded(child: SizedBox()),
          IconButton(
            icon: const Icon(Icons.mode),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            visualDensity: const VisualDensity(horizontal: -3),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            visualDensity: const VisualDensity(horizontal: -3),
          )
        ]),
      ),
    );
  }
}
