import 'package:flutter/material.dart';
import 'package:rest_api_app/helpers/snak_bar_helper.dart';
import 'package:rest_api_app/models/todo.dart';
import 'package:rest_api_app/models/todonavi.dart';
import 'package:rest_api_app/page/todo/todo.dart';
import 'package:rest_api_app/services/todo_api.dart';
import 'package:rest_api_app/widget/card_todo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> todos = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  _buildBody() {
    return Visibility(
      visible: isLoading,
      replacement: RefreshIndicator(
        onRefresh: fetchData,
        child: Visibility(
          visible: todos.isNotEmpty,
          replacement: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/demo.jpg'),
                  backgroundColor: Colors.red,
                ),
                Text(
                  'No have Todo!',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(10.0),
            child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: todos.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final heroTag = 'todo_$index';
                  return CardTodo(
                    todo: item,
                    index: index,
                    onTap: () async =>
                        await navigatieTodoPagev2(index, item, heroTag),
                    heroTag: heroTag,
                  );
                }).toList()),
          ),
        ),
      ),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _buildFloatingActionButton() {
    final heroTag = 'addTodos';
    return FloatingActionButton(
      onPressed: () => navigatieTodoPage(heroTag),
      child: Icon(
        Icons.add,
        size: 40,
      ),
    );
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      todos = await TodoApi.getApi();
    } catch (error) {
      showErrorMessage(message: 'Error fetching data: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> navigatieTodoPage(String heroTag) async {
    final route = MaterialPageRoute(
      builder: (context) => TodoPage(heroTag: heroTag),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchData();
  }

  Future<void> navigatieTodoPagev2(int index, Todo todo, String heroTag) async {
    // ignore: unused_local_variable
    final route = MaterialPageRoute<Todonavi>(
      builder: (context) => TodoPage(
        index: index,
        todo: todo,
        heroTag: heroTag,
      ),
    );
    final route2 = PageRouteBuilder<Todonavi>(
      transitionDuration: Duration(milliseconds: 300), // Tăng thời gian
      pageBuilder: (context, animation, secondaryAnimation) => TodoPage(
        index: index,
        todo: todo,
        heroTag: heroTag,
      ),
    );
    final Todonavi? result = await Navigator.push(context, route2);
    if (result != null) {
      if (result.x == 2) {
        setState(() {
          todos.removeWhere(
            (element) => element.sId == result.todo.sId,
          );
        });
        return;
      }
      if (result.x == 1) {
        setState(() {
          todos = todos.map((todo) {
            if (todo.sId == result.todo.sId) {
              return Todo(
                sId: todo.sId,
                title: result.todo.title,
                description: result.todo.description,
                isCompleted: todo.isCompleted,
                createdAt: todo.createdAt,
                updatedAt: DateTime.now(), // Cập nhật thời gian
              );
            }
            return todo; // Trả lại các phần tử không thay đổi
          }).toList();
        });
        return;
      }
      if (result.x == 0) {
        setState(() {
          todos.add(result.todo);
        });
        return;
      }
      setState(() {
        isLoading = true;
      });
      fetchData();
    } else {
      showErrorMessage(message: 'No data returned');
    }
  }

  Future<void> deleteById(String id) async {
    final res = await TodoApi.deleteApiById(id);
    if (mounted) {
      if (res) {
        showSuccessMessage(message: 'Xóa thành công');
        setState(() {
          todos.removeWhere((todo) => todo.sId == id);
        });
      } else {
        showErrorMessage(message: "Thất bại.");
      }
    }
  }
}
