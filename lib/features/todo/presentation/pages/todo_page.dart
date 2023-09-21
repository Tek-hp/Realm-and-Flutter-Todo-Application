import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:todorealm/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todorealm/features/todo/presentation/widgets/todo_list.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is TodoAddInitialState) {
          showToast('Fill form');
        }
        if (state is TodoAddSuccessState) {
          showToast('Added todo');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Todos'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: const TodoListWidget(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            mini: true,
            onPressed: () {
              BlocProvider.of<TodoBloc>(context).add(AddTodo());
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
