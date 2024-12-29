import 'package:flutter/material.dart';
import 'package:rest_api_app/models/users.dart';
import 'package:rest_api_app/services/user_api.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Users> users = [];
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
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          tileColor: users[index].gender! == 'male'
              ? const Color.fromARGB(255, 142, 204, 255)
              : Color.fromARGB(255, 255, 134, 174),
          subtitle: Text(
            users[index].email.toString(),
            style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
          ),
          title: Text(
            users[index].name.toString(),
            style: TextStyle(color: const Color.fromARGB(255, 61, 61, 61)),
          ),
          leading: Image.network(
            users[index].picture!.large.toString(),
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  _buildFloatingActionButton() {
    return FloatingActionButton(
        onPressed: () {}, child: Image.asset('assets/images/demo.jpg'));
  }

  Future<void> fetchData() async {
    final response = await UserApi.fetchApi();
    setState(() {
      users = response;
    });
  }
}
