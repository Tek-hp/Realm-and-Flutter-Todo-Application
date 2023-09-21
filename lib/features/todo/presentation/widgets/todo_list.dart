import 'package:flutter/material.dart';
import 'package:todorealm/features/todo/presentation/widgets/todo_tile.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: ListView.separated(
        itemCount: 3,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10);
        },
        itemBuilder: (BuildContext context, int index) {
          return const TodoTile();
        },
      ),
    );
  }
}
