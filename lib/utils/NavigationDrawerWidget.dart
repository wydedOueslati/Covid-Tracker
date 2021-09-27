import 'package:covid19_news/dash/home.dart';
import 'package:covid19_news/dash/stats.dart';
import 'package:covid19_news/dash/symptoms.dart';
import 'package:flutter/material.dart';


class NavigationDrawerWidget extends StatefulWidget {
  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    // final name = 'Sarah Abs';
    // final email = 'sarah@abs.com';
    // final urlImage =
    //     'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            // buildHeader(
            //   urlImage: urlImage,
            //   name: name,
            //   email: email,
            //   onClicked: () => Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => UserPage(
            //       name: 'Sarah Abs',
            //       urlImage: urlImage,
            //     ),
            //   )),
            // ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  // const SizedBox(height: 12),
                  // buildSearchField(),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Home',
                    icon: Icons.home_outlined,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Recent Statistics',
                    icon: Icons.favorite_border,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Symptoms',
                    icon: Icons.healing_outlined,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'News',
                    icon: Icons.update,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: Colors.black),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Settings',
                    icon: Icons.account_tree_outlined,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Notifications',
                    icon: Icons.notifications_outlined,
                    onClicked: () => selectedItem(context, 5),
                  ),
                  buildMenuItem(
                    text: 'Help and Feedback',
                    icon: Icons.account_tree_outlined,
                    onClicked: () => selectedItem(context, 6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchField() {
    final color = Colors.white;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.black;
    final hoverColor = Colors.black38;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => HomePage(),
        //));
        setState(() {
        
        });
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StatsPage(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SymptomsPage(),
        ));
        break;
    }
  }
}