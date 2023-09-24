import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todorealm/features/todo/data/models/realm/todo_realm_model.dart';
import 'package:todorealm/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todorealm/features/todo/presentation/widgets/todo_tile.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<TodoRealmModel> data = [];
    return BlocConsumer<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is TodoSuccessState) {
          data = state.data!;
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              if (state is TodoLoadingState)
                Expanded(
                  child: Row(
                    children: [
                      const Expanded(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Text(state.loadingMessage),
                      )
                    ],
                  ),
                ),
              Expanded(
                flex: 9,
                child: ListView.separated(
                  itemCount: data.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return data.isEmpty
                        ? const Center(
                            child: Text('Add your notes to see more'),
                          )
                        : TodoTile(
                            todoItem: TodoRealmModel(
                              data[index].id,
                              data[index].summary,
                              data[index].isComplete,
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
