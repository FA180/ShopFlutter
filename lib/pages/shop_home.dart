import 'package:dono/pages/add_product_screen.dart';
import 'package:dono/pages/item_list_page.dart';
import 'package:dono/pages/post_screen.dart' as PostSceen;
import 'package:flutter/material.dart';
import 'edit_item_page.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'profile.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ShopHome extends StatefulWidget {
  static const String routeName = '/home';
  @override
  _ShopHome createState() => _ShopHome();
}

class _ShopHome extends State<ShopHome> {
  int _selectedIndex = 0;

  // Define widgets for each tab
  Widget _buildHomeTab() {
    return const PostScreen();
  }

  Widget _buildOrdersTab() {
    return Center(child: Text('Orders Page Content'));
  }

  Widget _buildRequestsTab() {
    return Center(child: Text('Requests Page Content'));
  }

  Widget _buildProfileTab() {
    return ProfilePage();
  }

  // Handle tab change
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Build AppBar based on selected index
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 45, 195, 137),
      title: Text("iihdaa",
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 30,
              color: Color.fromARGB(255, 23, 92, 62))),
      actions: [
        IconButton(
          padding: EdgeInsets.only(right: 20),
          onPressed: () {},
          icon: FaIcon(
            FontAwesomeIcons.solidBell,
            color: const Color.fromARGB(244, 255, 255, 255),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeTab(),
          _buildOrdersTab(),
          _buildRequestsTab(),
          _buildProfileTab(),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: GNav(
            gap: 8,
            onTabChange: _onItemTapped,
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade900,
            padding: const EdgeInsets.all(16),
            tabs: [
              GButton(
                icon: Icons.home,
                text: "Home",
                iconSize: 25,
              ),
              GButton(
                icon: FontAwesomeIcons.boxOpen,
                text: "Orders",
                iconSize: 20,
              ),
              GButton(
                icon: Icons.assignment,
                text: "Requests",
                iconSize: 25,
              ),
              GButton(
                icon: Icons.person,
                text: "Profile",
                iconSize: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
