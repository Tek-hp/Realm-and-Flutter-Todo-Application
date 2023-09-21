import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.purpleAccent.withOpacity(0.3),
      ),
      child: const Text('to-do'),
    );
  }
}
