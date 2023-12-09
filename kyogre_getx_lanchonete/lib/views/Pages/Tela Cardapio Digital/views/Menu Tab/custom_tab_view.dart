import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../app/widgets/Custom/CustomText.dart';

class MyTabbedPage extends StatefulWidget {
  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabTitles = [
    'Tab 1',
    'Tab 2',
    'Tab 3',
    'Tab 4',
    'Tab 5',
    'Tab 6',
    'Tab 7'
  ];
  final List<String> tabContents = [
    'Content of Tab 1',
    'Content of Tab 2',
    'Content of Tab 3',
    'Content of Tab 3',
    'Content of Tab 3',
    'Content of Tab 3',
    'Content of Tab 3',
    'Content of Tab 3',
    'Content of Tab 3',
    'Content of Tab 3',
    'Content of Tab 3',
    'Content of Tab 3',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabTitles.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: List<Widget>.generate(
            tabTitles.length,
                (index) => TabBarGradiente(
                tabTitles[index], _tabController.index == index),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children:
        tabContents.map((content) => Center(child: Text(content))).toList(),
      ),
    );
  }

  Widget TabBarGradiente(String nome, bool isSelected) {
    return Tab(
      child: Container(
        width: 120,
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0.5, 1),
              blurRadius: 5,
              spreadRadius: 2,
              color: Colors.yellow,
            ),
          ],
          gradient: isSelected
              ? LinearGradient(colors: [Colors.greenAccent, Colors.green])
              : LinearGradient(colors: [
            Colors.deepPurple.shade100,
            CupertinoColors.activeBlue.highContrastElevatedColor
          ]),
        ),
        child: Center(
          child: CustomText(
            text: nome,
            color: isSelected ? Colors.white : Colors.black,
            size: 12,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
