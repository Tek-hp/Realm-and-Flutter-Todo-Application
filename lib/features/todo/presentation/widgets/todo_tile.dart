import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todorealm/features/todo/data/models/realm/todo_realm_model.dart';
import 'package:todorealm/features/todo/presentation/bloc/todo_bloc.dart';

enum MenuOption { edit, delete }

class TodoTile extends StatelessWidget {
  const TodoTile({super.key, required this.todoItem});

  final TodoRealmModel todoItem;

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
      child: Row(
        children: [
          Expanded(child: Text(todoItem.summary)),
          PopupMenuButton<MenuOption>(
            onSelected: (MenuOption menuItem) {
              if (menuItem == MenuOption.delete) {
                BlocProvider.of<TodoBloc>(context).add(DeleteTodoEvent(todoItem));
                return;
              }

              BlocProvider.of<TodoBloc>(context).add(ShowUpdateDialogEvent(todoItem));
            },
            itemBuilder: (context) => [
              const PopupMenuItem<MenuOption>(
                value: MenuOption.edit,
                child: ListTile(leading: Icon(Icons.edit), title: Text("Edit item")),
              ),
              const PopupMenuItem<MenuOption>(
                value: MenuOption.delete,
                child: ListTile(leading: Icon(Icons.delete), title: Text("Delete item")),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
