import 'package:flutter/material.dart';

class AppMenu extends StatefulWidget {
  const AppMenu({super.key, required this.title});

  final String title;

  @override
  State<AppMenu> createState() => AppMenuState();
}

class AppMenuState extends State<AppMenu> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 20,
          centerTitle: mounted,
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home_rounded),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.list_rounded),
              icon: Icon(Icons.list_outlined),
              label: 'List',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.add_rounded),
              icon: Icon(Icons.add_outlined),
              label: 'Add',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.settings_rounded),
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
            )
          ],
        ),
        body: <Widget>[
          Container(),
          Container(),
          Container(),
          Container()
        ][currentPageIndex]);
  }
}
