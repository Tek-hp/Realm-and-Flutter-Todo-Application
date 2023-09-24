import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:realm/realm.dart';
import 'package:todorealm/core/extention/realm_extension.dart';
import 'package:todorealm/features/todo/data/models/realm/todo_realm_model.dart';
import 'package:todorealm/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todorealm/features/todo/presentation/widgets/todo_list.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _summaryTextController = TextEditingController();
  final _updateSummaryTextController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<TodoBloc>(context).add(ReadTodoEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoBloc, TodoState>(
      listener: (context, state) async {
        if (state is UpdateTodoState) {
          bool cancelUpdate = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                content: SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      TextField(
                        controller: _updateSummaryTextController,
                        decoration: InputDecoration(
                          labelText: state.todo.summary,
                          labelStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final summary = _updateSummaryTextController.text.trim();
                      if (summary.isEmpty) {
                        showToast('Please enter a note');
                        return;
                      }

                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              );
            },
          );

          if (context.mounted && !cancelUpdate) {
            log(' Changing state because Cancle = $cancelUpdate');

            BlocProvider.of<TodoBloc>(context).add(UpdateTodoEvent(
              state.todo.copyWith(summary: _updateSummaryTextController.text.trim()),
            ));
          }
        }
        if (state is AddTodoState) {
          // ignore: use_build_context_synchronously
          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                content: SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      TextField(
                        controller: _summaryTextController,
                        decoration: InputDecoration(
                          labelText: 'Enter Todo Note',
                          labelStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final summary = _summaryTextController.text.trim();
                      if (summary.isEmpty) {
                        showToast('Please enter a note');
                        return;
                      }

                      BlocProvider.of<TodoBloc>(context).add(AddTodoEvent(
                        TodoRealmModel(
                          ObjectId(),
                          summary,
                          false,
                        ),
                      ));
                      Navigator.of(context).pop();
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              );
            },
          );
        }
        if (state is TodoSuccessState) {
          _summaryTextController.clear();
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
              BlocProvider.of<TodoBloc>(context).add(ShowAddDialogEvent());
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
