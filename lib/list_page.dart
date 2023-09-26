import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod_tutorial/list_item.dart';
import 'package:flutter_riverpod_tutorial/models/Todo.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  // _todo should be a state item
  List<Todo> _todos = [
    Todo(
      name: 'Buy milk',
      checked: false,
    ),
    Todo(
      name: 'Buy eggs',
      checked: false,
    ),
    Todo(
      name: 'Buy bread',
      checked: false,
    ),
  ];

  _onTodoChanged(Todo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

  _buildTodoList() {
    return _todos
        .map((todo) => ListItem(
              todo: todo,
              onTodoChanged: _onTodoChanged,
            ))
        .toList();
  }

  _reverseTodos() {
    print(_todos.map((e) => e.name));
    print(_todos.reversed.map((e) => e.name));

    setState(() {
      _todos = _todos.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: const Text('List Page'),
            leading: CupertinoButton(
              padding: const EdgeInsets.all(10),
              child: const Text('Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            trailing: CupertinoButton(
                padding: const EdgeInsets.all(10),
                child: const Text('Reverse'),
                onPressed: () {
                  _reverseTodos();
                })),
        child: SafeArea(
            child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: _buildTodoList())));
  }
}
