import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

part '06_todo_demo_provider.g.dart';

enum TodoStatus {
  pending,
  complete,
}

class Todo {
  final String id;
  final String title;
  final String? description;
  final TodoStatus status;
  final DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    this.description,
    this.status = TodoStatus.pending,
    required this.createdAt
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    TodoStatus? status,
    DateTime? createdAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'status': status.name,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    status: TodoStatus.values.firstWhere((e) => e.name == json['status']),
    createdAt: DateTime.parse(json['createdAt']),
  );
  
}

@riverpod
class TodoList extends _$TodoList {
  static const String _storageKey = 'todos';
  
  @override
  Future<List<Todo>> build() async {
    return await _loadFromStorage();
  }

  // 获取本地数据
  Future<List<Todo>> _loadFromStorage () async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);

    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);

    return jsonList
      // .where((json) => json['status'] == currentFilter.name) // 关键过滤步骤
      .map((json) => Todo.fromJson(json))
      .toList();
  }

  // 保存本地数据
  Future<void> _saveToStorage (List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(todos.map((t) => t.toJson()).toList());
    await prefs.setString(_storageKey, jsonString); // 关键方法
  }

  // 新增
  Future<void> addTodo(String title, { String? description }) async {
    final currentState = await future; // 这是什么意思???
    final newTodo = Todo(
      id: DateTime.now().microsecondsSinceEpoch.toString(), 
      title: title, 
      description: description, 
      createdAt: DateTime.now()
    );

    final newList = [...currentState, newTodo];
    state = AsyncData(newList); // 这里的AsyncData是什么意思?
    await _saveToStorage(newList);
  }

  // 转换状态
  Future<void> toggleStatus(String id) async {
    final currentState = await future;
    final newList = currentState.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(
          status: todo.status == TodoStatus.pending
            ? TodoStatus.complete
            : TodoStatus.pending
        );
      }
      return todo;
    }).toList();

    state = AsyncData(newList);
    await _saveToStorage(newList);
  }

  // 删除
  Future<void> deleteTodo(String id) async {
    final currentState = await future;
    final newList = currentState.where((todo) => todo.id != id).toList();
    state = AsyncData(newList);
    await _saveToStorage(newList);
  }

  // 更新数据
  Future<void> updateTodo(String id, {String? title, String? description}) async {
    final currentState = await future;
    final newList = currentState.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(title: title, description: description);
      }
      return todo;
    }).toList();
    
    state = AsyncData(newList);
    await _saveToStorage(newList);
  }
  
}

// 过滤器
enum TodoFilter { all, pending, complete }

@riverpod
class CurrentFilter extends _$CurrentFilter {
  @override
  TodoFilter build() {
    return TodoFilter.all;
  }

  void setFilter(TodoFilter filter) => state = filter;
}

@riverpod
Future<Map<String, int>> todoStats (Ref ref) async {
  final todos = await ref.watch(todoListProvider.future); // 这是什么手法...
  return {
    'total': todos.length,
    'pending': todos.where((t) => t.status == TodoStatus.pending).length,
    'complete': todos.where((t) => t.status == TodoStatus.complete).length,
  };
}

@riverpod
Future<List<Todo>> filteredTodoList(Ref ref) async {
  final todos = await ref.watch(todoListProvider.future);
  final filter = ref.watch(currentFilterProvider);
  return switch (filter) {
    TodoFilter.all => todos,
    TodoFilter.pending => todos.where((t) => t.status == TodoStatus.pending).toList(),
    TodoFilter.complete => todos.where((t) => t.status == TodoStatus.complete).toList(),
  };
}