import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:realm/realm.dart';
import 'package:todorealm/core/extention/realm_extension.dart';
import 'package:todorealm/features/todo/data/models/realm/todo_realm_model.dart';
import 'package:todorealm/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todorealm/features/todo/presentation/widgets/todo_list.dart';

enum NoteAction {
  add,
  update,
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _summaryTextController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<TodoBloc>(context).add(ReadTodoEvent());
    super.initState();
  }

  Future<bool> showNoteDialog(NoteAction action) async {
    bool? cancel = await showDialog<bool>(
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
                    labelText: 'Enter your note',
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
                final summary = _summaryTextController.text.trim();
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

    if (cancel == null) {
      _summaryTextController.clear();
    }

    return cancel ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) async {
        if (state is TodoSuccessState) {
          _summaryTextController.clear();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Todos'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: TodoListWidget(
          onEditPressed: (todo) async {
            final isCancelled = await showNoteDialog(NoteAction.update);

            if (mounted && !isCancelled) {
              BlocProvider.of<TodoBloc>(context).add(
                UpdateTodoEvent(
                  todo.copyWith(summary: _summaryTextController.text),
                ),
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          mini: true,
          onPressed: () async {
            final isCancelled = await showNoteDialog(NoteAction.add);

            if (!isCancelled && mounted) {
              BlocProvider.of<TodoBloc>(context).add(
                AddTodoEvent(
                  TodoRealmModel(
                    ObjectId(),
                    _summaryTextController.text,
                    false,
                  ),
                ),
              );
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
