import 'package:flutter/material.dart';
import 'package:rest_api_app/models/rive_navi.dart';
import 'package:rest_api_app/page/speechtotext/speechtotext.dart';
import 'package:rest_api_app/screens/bartender.dart';
import 'package:rest_api_app/screens/my_home.dart';
import 'package:rest_api_app/screens/settings.dart';
import 'package:rest_api_app/screens/text_to_speech.dart';
import 'package:rive/rive.dart';

class MyHomeApp extends StatefulWidget {
  final Widget widget;
  const MyHomeApp({super.key, required this.widget});

  @override
  State<MyHomeApp> createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  List<SMIBool> boolIcons = [];
  List<StateMachineController?> listController = [];
  List<Widget> listPage = [
    MyHomePage(),
    Bartender(),
    TTSExample(),
    Speechtotext(),
    SettingsPage(),
  ];
  int selectedIcon = 0;
  void animateIcon(int index) {
    boolIcons[index].change(true);
    Future.delayed(Duration(seconds: 1), () {
      boolIcons[index].change(false);
    });
  }

  void riveOnInit(Artboard artboard, {required String stateName}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateName);
    artboard.addController(controller!);
    listController.add(controller);
    boolIcons.add(controller.findInput<bool>('active') as SMIBool);
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIcon = index;
    });
  }

  @override
  void dispose() {
    for (var i in listController) {
      i?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: SafeArea(
            child: IndexedStack(
          index: selectedIcon,
          children: listPage,
        )),
        extendBodyBehindAppBar: true,
        bottomNavigationBar: _buildBottomNavigationBar());
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: List.generate(naviItems.length, (index) {
        final riveIcon = naviItems[index].rive;
        return BottomNavigationBarItem(
          backgroundColor: Colors.red,
          label: riveIcon.artboard,
          icon: GestureDetector(
            onTap: () {
              animateIcon(index);
              setState(() {
                selectedIcon = index;
              });
            },
            child: Opacity(
              opacity: selectedIcon == index ? 1 : 0.5,
              child: SizedBox(
                width: 46,
                height: 46,
                child: RiveAnimation.asset(
                  riveIcon.src,
                  artboard: riveIcon.artboard,
                  onInit: (artboard) {
                    riveOnInit(artboard, stateName: riveIcon.stateName);
                  },
                ),
              ),
            ),
          ),
        );
      }),
      currentIndex: selectedIcon,
      showSelectedLabels: false,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color.fromARGB(255, 100, 163, 73),
      showUnselectedLabels: false,
    );
  }

  _buildAppBar() {
    return AppBar(
      leading: widget.widget,
    );
  }
}
