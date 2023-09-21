import 'package:todorealm/features/todo/domain/repositories/todo_repository.dart';

abstract class TodoUseCases {
  Future<void> createTodo();
  Future<void> updateTodo();
  Future<void> deleteTodo();
}

class TodoUseCasesImpl implements TodoUseCases {
  TodoUseCasesImpl(TodoRepository repository) : _repository = repository;

  late final TodoRepository _repository;
  @override
  Future<void> createTodo() async {
    return await _repository.createTodo();
  }

  @override
  Future<void> deleteTodo() async {
    return await _repository.deleteTodo();
  }

  @override
  Future<void> updateTodo() async {
    return await _repository.updateTodo();
  }
}
