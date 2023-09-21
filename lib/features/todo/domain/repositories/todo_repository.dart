abstract class TodoRepository {
  Future<void> createTodo();
  Future<void> updateTodo();
  Future<void> deleteTodo();
}
