import 'package:flutter/material.dart';
import 'package:food_inventory/pages/add_page.dart';
import 'package:food_inventory/pages/home_page.dart';
import 'package:food_inventory/pages/shop_page.dart';
import 'package:food_inventory/pages/settings_page.dart';

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
        appBar: currentPageIndex == 3
            ? AppBar(
                title: Text(
                  widget.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                elevation: 20,
                centerTitle: mounted,
              )
            : null,
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
              label: 'Accueil',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.shopping_bag_rounded),
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Magasin',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.settings_rounded),
              icon: Icon(Icons.settings_outlined),
              label: 'Paramètres',
            )
          ],
        ),
        body: <Widget>[
          const HomePage(),
          const ShopPage(),
          const SettingsPage()
        ][currentPageIndex]);
  }
}
