import 'dart:convert';

import 'package:dreamcatcher/routes/community.dart';
import 'package:dreamcatcher/routes/dreams_list.dart';
import 'package:dreamcatcher/routes/graphs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../observables.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int bottomSelectedIndex = 0;

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Icon(Icons.bar_chart),
        label: 'Graphs',
      ),
      BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Community')
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: const <Widget>[
        DreamsList(),
        Graphs(),
        Community(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) => bottomTapped(i),
        currentIndex: bottomSelectedIndex,
        items: buildBottomNavBarItems(),
      ),
    );
  }
}
