import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rest_api_app/page/tail/detail_tail.dart';

class Bartender extends StatefulWidget {
  @override
  _BartenderState createState() => _BartenderState();
}

class _BartenderState extends State<Bartender> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<String> list = ['Tuan', 'Tu', 'Phat', 'Tai'];
  List<String> listTial = [
    'Tuan',
    'Tu',
    'Phat',
    'Tai',
    'Tuan',
    'Tu',
    'Phat',
    'Tai',
    'Tuan',
    'Tu',
    'Phat',
    'Tai'
  ];
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < list.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

// Dừng Timer khi người dùng tự tay thay đổi trang
  void _stopAutoScroll() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  void _restartAutoScroll() {
    _startAutoScroll(); // Bắt đầu lại Timer sau khi người dùng thay đổi trang
  }

  @override
  void dispose() {
    _timer.cancel(); // Hủy Timer khi widget bị hủy
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: list.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
                _stopAutoScroll();
                _restartAutoScroll();
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/demo.jpg',
                        ),
                        fit: BoxFit.cover),
                    color: const Color.fromARGB(255, 24, 24, 24),
                    borderRadius: BorderRadius.all(
                        Radius.circular(12)), // Bo góc cho container
                  ),
                  child: Center(
                    child: Text(
                      list[index],
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            list.length,
            (index) => AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index ? Colors.blue : Colors.grey,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
            itemCount: listTial.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 24, 24, 24),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Center(
                  child: Text(
                    listTial[index],
                    style: TextStyle(
                      color: Colors.white, // Màu chữ để dễ nhìn trên nền tối
                      fontSize: 16, // Cỡ chữ tùy ý
                    ),
                  ),
                ),
              );
            },
            scrollDirection: Axis.horizontal,
            physics: AlwaysScrollableScrollPhysics(),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Data',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 160,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            itemCount: listTial.length,
            separatorBuilder: (context, index) {
              return SizedBox(width: 10); // Khoảng cách giữa các phần tử
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DetailTail()));
                },
                child: Container(
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                      image: AssetImage('assets/images/demo.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      listTial[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              );
            },
            scrollDirection: Axis.horizontal,
            physics: AlwaysScrollableScrollPhysics(),
          ),
        )
      ],
    );
  }
}
