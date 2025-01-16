import 'package:flutter/material.dart';
import 'package:rest_api_app/navi/bottom.dart';
import 'package:rest_api_app/screens/ai_chat_bot.dart';

class DrawerApp extends StatefulWidget {
  const DrawerApp({super.key});

  @override
  State<DrawerApp> createState() => _DrawerAppState();
}

class _DrawerAppState extends State<DrawerApp> {
  double xOffset = 0;
  double yOffset = 0;
  double scale = 1;
  bool isDrawerOpen = true;
  int selected = 0;
  double topPosition = 128.0;
  final List<Map<String, dynamic>> menuItems = [
    {"icon": Icons.home, "name": "Home"},
    {"icon": Icons.account_circle, "name": "Profile"},
    {"icon": Icons.settings, "name": "Settings"},
    {"icon": Icons.notifications, "name": "Notifications"},
    {"icon": Icons.help, "name": "Help"},
    {"icon": Icons.logout, "name": "Logout"},
  ];
  @override
  Widget build(BuildContext context) {
    var gestureDetector = GestureDetector(
      onTap: () {
        if (isDrawerOpen) {
          setState(() {
            xOffset = 200;
            yOffset = 80;
            scale = 0.8;
          });
        } else {
          setState(() {
            xOffset = 0;
            yOffset = 0;
            scale = 1;
          });
        }
        isDrawerOpen = !isDrawerOpen;
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: isDrawerOpen
            ? Icon(Icons.menu, key: ValueKey('menu'))
            : Icon(Icons.arrow_back_sharp, key: ValueKey('arrow')),
      ),
    );
    List<Widget> listScreens = [
      MyHomeApp(
        widget: gestureDetector,
      ),
      ImageChat(
        widget: gestureDetector,
      ),
      Placeholder(),
      Placeholder(),
      Placeholder(),
      Placeholder(),
    ];
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            color: Colors.lightGreen[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/demo.jpg'),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ), // Đường dẫn ảnh
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tính Lê Văn',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'levati.it@fb.com',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      final item = menuItems[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = index;
                            // Tính toán vị trí để khung trượt đến ô được chọn
                            topPosition =
                                128.0 + 60.0 * index; // Tính toán vị trí y
                          });
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 16,
                                children: [
                                  Icon(
                                    item["icon"],
                                    color: selected == index
                                        ? Colors.white
                                        : Colors.green,
                                  ),
                                  Text(
                                    item["name"],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: selected == index
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            top: topPosition, // Vị trí thay đổi khi chọn phần tử
            left: 4, // Khoảng cách từ bên trái
            right: 16,
            duration: Duration(milliseconds: 300), // Thời gian hiệu ứng
            curve: Curves.easeInOut, // Đường cong hiệu ứng
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                margin: EdgeInsets.only(right: 136),
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen),
                  color: const Color.fromARGB(35, 76, 175, 79),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(scale),
            duration: Duration(milliseconds: 300),
            child: IndexedStack(
              index: selected, // Chỉ hiển thị màn hình được chọn
              children: listScreens, // Danh sách các màn hình
            ),
          )
        ],
      ),
    );
  }
}
