import 'package:flutter/material.dart';
import 'package:rest_api_app/helpers/snak_bar_helper.dart';
import 'package:rest_api_app/models/todo.dart';
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
      title: Text(
        'Rest Api Call',
        style: TextStyle(color: Colors.green),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return Visibility(
      visible: isLoading,
      replacement: RefreshIndicator(
        onRefresh: fetchData,
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
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: navigatieTodoPage,
      shape: CircleBorder(),
      child: ClipOval(
        // child: Image.asset(
        //   'assets/images/demo.jpg',
        //   fit: BoxFit
        //       .cover,
        // ),
        child: Text(
          '+',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
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
      if (mounted) {
        SnackBarHelper.showErrorMessage(context, 'Error fetching data: $error');
      }
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
    final route = MaterialPageRoute(
      builder: (context) => TodoPage(
        index: index,
        todo: todo,
      ),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchData();
  }

  Future<void> deleteById(String id) async {
    final res = await TodoApi.deleteApiById(id);
    if (mounted) {
      if (res) {
        SnackBarHelper.showSuccessMessage(context, 'Xóa thành công');
        setState(() {
          todos.removeWhere((todo) => todo.sId == id);
        });
      } else {
        SnackBarHelper.showErrorMessage(context, "Thất bại.");
      }
    }
  }
}
