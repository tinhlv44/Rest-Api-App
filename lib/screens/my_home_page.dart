import 'package:flutter/material.dart';
import 'package:rest_api_app/helpers/snak_bar_helper.dart';
import 'package:rest_api_app/models/todo.dart';
import 'package:rest_api_app/models/todonavi.dart';
import 'package:rest_api_app/screens/todo.dart';
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
      appBar: _buildAppBar(),
      body: _buildBody(context),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.api, color: Colors.green),
          SizedBox(
            width: 8,
          ),
          Text(
            'Rest Api Call',
            style: TextStyle(color: Colors.green),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  _buildBody(BuildContext context) {
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
            padding: EdgeInsets.all(10.0),
            child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: todos.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return CardTodo(
                    todo: item,
                    index: index,
                    onTap: () async => await navigatieTodoPagev2(index, item),
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
    return FloatingActionButton(
      onPressed: navigatieTodoPage,
      child: Text(
        '+',
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.greenAccent[300]),
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
      showErrorMessage(context, message: 'Error fetching data: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> navigatieTodoPage() async {
    final route = MaterialPageRoute(
      builder: (context) => TodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchData();
  }

  Future<void> navigatieTodoPagev2(int index, Todo todo) async {
    final route = MaterialPageRoute<Todonavi>(
      builder: (context) => TodoPage(
        index: index,
        todo: todo,
      ),
    );
    final Todonavi? result = await Navigator.push(context, route);
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No data returned')),
      );
    }
  }

  Future<void> deleteById(String id) async {
    final res = await TodoApi.deleteApiById(id);
    if (mounted) {
      if (res) {
        showSuccessMessage(context, message: 'Xóa thành công');
        setState(() {
          todos.removeWhere((todo) => todo.sId == id);
        });
      } else {
        showErrorMessage(context, message: "Thất bại.");
      }
    }
  }
}
