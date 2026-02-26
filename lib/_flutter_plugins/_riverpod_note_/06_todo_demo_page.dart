import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application/providers/06_todo_demo_provider.dart';

@RoutePage()
class TodoDemoPage extends ConsumerWidget {
  const TodoDemoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoAsync = ref.watch(filteredTodoListProvider);
    final statsAsync = ref.watch(todoStatsProvider);
    final currentFilter = ref.watch(currentFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('The List'),
        actions: [
          statsAsync.when(
            loading: () => SizedBox(),
            error: (_, _) => SizedBox(), 
            data: (stats) => Padding(
              padding: EdgeInsets.all(20),
              child: Text('${stats['complete']}/${stats['total']}'),
            ), 
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50), 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilterChip(
                label: Text('All'), 
                selected: currentFilter == TodoFilter.all,
                onSelected: (_) {
                  ref.read(currentFilterProvider.notifier).setFilter(TodoFilter.all);
                }
              ),
              FilterChip(
                label: Text('Pending'), 
                selected: currentFilter == TodoFilter.pending,
                onSelected: (_) {
                  ref.read(currentFilterProvider.notifier).setFilter(TodoFilter.pending);
                }
              ),
              FilterChip(
                label: Text('Complete'), 
                selected: currentFilter == TodoFilter.complete,
                onSelected: (_) {
                  ref.read(currentFilterProvider.notifier).setFilter(TodoFilter.complete);
                }
              )
            ],
          )
        ),
      ),
      body: todoAsync.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')), 
        data: (todos) {
          if (todos.isEmpty) return Center(child: Text('I do got some time on my hand'));
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              
              return Dismissible(
                key: Key(todo.id), 
                background: Container(color: Colors.red),
                onDismissed: (_) {
                  ref.read(todoListProvider.notifier).deleteTodo(todo.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${todo.title} is done!')
                    )
                  );
                },
                child: Row(
                  children: [
                    Checkbox(
                      value: todo.status == TodoStatus.complete,
                      onChanged: (_) {
                        ref.read(todoListProvider.notifier).toggleStatus(todo.id);
                      },
                    ),
                    Expanded(
                      child: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.status == TodoStatus.complete
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showEditDialog(context, ref, todo);
                      },
                    ),
                  ],
                )
              );
            }
          );
        }, 
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context, ref);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('New Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
              autocorrect: true,
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: 'description'),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: Text('Cancel')
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                ref.read(todoListProvider.notifier).addTodo(
                  titleController.text,
                  description: descController.text.isEmpty
                    ? ''
                    : descController.text
                );
                Navigator.pop(context);
              }
            }, 
            child: Text('Add')
          )
        ],
      )
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, Todo todo) {
    final titleController = TextEditingController(text: todo.title);
    final descController = TextEditingController(text: todo.description ?? '');
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('编辑待办'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: '标题'),
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: '描述'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('取消'),
          ),
          TextButton(
            onPressed: () {
              ref.read(todoListProvider.notifier).updateTodo(
                todo.id,
                title: titleController.text,
                description: descController.text,
              );
              Navigator.pop(context);
            },
            child: Text('保存'),
          ),
        ],
      ),
    );
  }
  
}
