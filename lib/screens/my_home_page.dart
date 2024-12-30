import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest_api_app/models/users.dart';
import 'package:rest_api_app/screens/add_do.dart';
import 'package:rest_api_app/screens/edit_page.dart';
import 'package:rest_api_app/services/user_api.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Users> users = [];
  List<dynamic> items = [];
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
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final String id = items[index]['_id'];
            return ListTile(
              leading: CircleAvatar(
                child: Text(
                  index.toString(),
                  style: TextStyle(color: Colors.red),
                ),
              ),
              title: Text(items[index]['title'].toString()),
              trailing: PopupMenuButton(
                onSelected: (value) {
                  value ? EditPage() : {deleteById(id)};
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text('Edit'),
                      value: true,
                    ),
                    PopupMenuItem(
                      child: Text('Delete'),
                      value: false,
                    ),
                  ];
                },
              ),
            );
          },
        ),
      ),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _buildFloatingActionButton() {
    return FloatingActionButton(
        onPressed: navigatieAddPage,
        //onPressed: fetchData,
        //child: Image.asset('assets/images/demo.jpg'));
        child: Text('+'));
  }

  Future<void> fetchData() async {
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final results = jsonDecode(response.body) as Map;
      setState(() {
        items = results['items'] as List;
      });
    } else {}
    setState(() {
      isLoading = false;
    });
  }

  Future<void> navigatieAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchData();
  }

  Future<void> deleteById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    response.statusCode == 200
        ? showSuccessMessage('Xóa thành công')
        : showErrorMessage(
            "Thất bại. Lỗi ${jsonDecode(response.body)['message'].toString()}");
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.lightGreen[400],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red[400],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
