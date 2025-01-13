import 'package:rive/rive.dart';

class RiveNavi {
  final String src, artboard, stateName;
  late SMIBool? status;

  RiveNavi(
      {required this.src,
      required this.artboard,
      required this.stateName,
      this.status});

  set setStatus(SMIBool state) {
    status = state;
  }
}

class NaviItem {
  final String title;
  final RiveNavi rive;

  NaviItem({required this.title, required this.rive});
}

List<NaviItem> naviItems = [
  NaviItem(
      title: 'Chat',
      rive: RiveNavi(
          src: 'assets/riv/animated_icon_set_-_1_color.riv',
          artboard: 'CHAT',
          stateName: 'CHAT_Interactivity')),
  NaviItem(
      title: 'Search',
      rive: RiveNavi(
          src: 'assets/riv/animated_icon_set_-_1_color.riv',
          artboard: 'SEARCH',
          stateName: 'SEARCH_Interactivity')),
  NaviItem(
      title: 'Timer',
      rive: RiveNavi(
          src: 'assets/riv/animated_icon_set_-_1_color.riv',
          artboard: 'TIMER',
          stateName: 'TIMER_Interactivity')),
  NaviItem(
      title: 'Bell',
      rive: RiveNavi(
          src: 'assets/riv/animated_icon_set_-_1_color.riv',
          artboard: 'BELL',
          stateName: 'BELL_Interactivity')),
  NaviItem(
      title: 'Settings',
      rive: RiveNavi(
          src: 'assets/riv/animated_icon_set_-_1_color.riv',
          artboard: 'SETTINGS',
          stateName: 'SETTINGS_Interactivity')),
];
