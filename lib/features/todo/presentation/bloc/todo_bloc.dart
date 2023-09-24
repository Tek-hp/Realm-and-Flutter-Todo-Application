import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todorealm/core/extention/realm_extension.dart';
import 'package:todorealm/features/todo/data/models/realm/todo_realm_model.dart';
import 'package:todorealm/features/todo/domain/usecases/todo_use_cases.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(
    this._addTodoUseCase,
    this._updateTodoUseCase,
    this._deleteTodoUseCase,
    this._readTodoUseCase,
  ) : super(TodoInitialState()) {
    on<ReadTodoEvent>(_readItemsInitially);
    on<ShowAddDialogEvent>(_showTodoAddDialog);
    on<ShowUpdateDialogEvent>(_showTodoUpdateDialog);
    on<AddTodoEvent>(_addTodo);
    on<UpdateTodoEvent>(_updateTodo);
    on<DeleteTodoEvent>(_deleteTodo);
    on<CancleUpdateTodoEvent>(_resetState);
    on((event, emit) => null);
  }

  final AddTodoUseCase _addTodoUseCase;
  final UpdateTodoUseCase _updateTodoUseCase;
  final DeleteTodoUseCase _deleteTodoUseCase;
  final ReadTodoUseCase _readTodoUseCase;

  void _resetState(CancleUpdateTodoEvent event, Emitter<TodoState> emit) {
    emit(const TodoSuccessState().copyWith());
  }

  Future<void> _showTodoUpdateDialog(ShowUpdateDialogEvent event, Emitter<TodoState> emit) async {
    emit(UpdateTodoState(event.todo));
  }

  Future<void> _showTodoAddDialog(ShowAddDialogEvent event, Emitter<TodoState> emit) async {
    emit(AddTodoState());
  }

  void _readItemsInitially(ReadTodoEvent event, Emitter<TodoState> emit) {
    emit(const TodoLoadingState(loadingMessage: 'Fetching your list'));

    final data = _updateView();

    emit(TodoSuccessState(successType: TodoSuccessType.read, data: data));
  }

  void _addTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    emit(const TodoLoadingState(loadingMessage: 'Adding your Note'));
    final success = _addTodoUseCase.call(event.todo);
    if (success) {
      final newList = _updateView();

      emit(TodoSuccessState(
        successType: TodoSuccessType.add,
        data: newList.isNotEmpty ? newList : null,
      ));
      return;
    }

    emit(const TodoFailureState(errorMessage: 'Could not Add your note'));
  }

  void _updateTodo(UpdateTodoEvent event, Emitter<TodoState> emit) {
    emit(const TodoLoadingState(loadingMessage: 'Updating your Note'));

    log('Again updating val == ${event.todo.getSTringValue()}');
    final success = _updateTodoUseCase.call(event.todo);
    if (success) {
      final newList = _updateView();

      emit(TodoSuccessState(
        successType: TodoSuccessType.update,
        data: newList.isNotEmpty ? newList : null,
      ));
      return;
    }

    emit(const TodoFailureState(errorMessage: 'Could not Update your note'));
  }

  Future<void> _deleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    emit(const TodoLoadingState(loadingMessage: 'Deleting your Note'));

    final success = _deleteTodoUseCase.call(event.todo);

    if (success) {
      final newList = _updateView();

      emit(TodoSuccessState(
        successType: TodoSuccessType.delete,
        data: newList.isNotEmpty ? newList : null,
      ));

      return;
    }

    emit(const TodoFailureState(errorMessage: 'Could not Delete your note'));
  }

  List<TodoRealmModel> _updateView() {
    final result = _readTodoUseCase.call(null);

    List<TodoRealmModel> listOfData = [];
    int index = 1;

    result.fold(
      (errorMessage) {
        log(errorMessage);
      },
      (successData) {
        for (var element in successData) {
          listOfData.add(
            TodoRealmModel(
              element.id,
              element.summary,
              element.isComplete,
            ),
          );
          log('$index : ${element.getSTringValue()}');
          index++;
        }
      },
    );

    return listOfData;
  }
}
