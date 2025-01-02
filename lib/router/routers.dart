import 'package:flutter/material.dart';
import 'package:rest_api_app/screens/login.dart';
import 'package:rest_api_app/screens/todo.dart';
import 'package:rest_api_app/screens/my_home_page.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => LoginScreen(
          show: () {},
        ),
    '/todo': (context) => TodoPage(),
    //'/details': (context) => DetailsPage(),
    // Thêm các route khác tại đây
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final builder = routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(builder: builder);
    }
    return MaterialPageRoute(
      builder: (context) => Container(), // Trang không tìm thấy
    );
  }
}
