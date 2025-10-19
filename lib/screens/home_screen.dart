import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samatoll/controller/navigation_controller.dart';
import 'package:samatoll/screens/dashboard.dart';
import 'package:samatoll/screens/graphics_screen.dart';
import 'package:samatoll/screens/notification_screen.dart';
import 'cultures_screen.dart';

class HomeScreen extends StatelessWidget {
  final NavigationController navController = Get.put(NavigationController());

  final List<Widget> _screens = [
    DashboardScreen(),
    GraphiquesScreen(),
    NotificationsScreen(),
    CulturesScreen(),
  ];

  final List<String> _titles = [
    'Tableau de bord',
    'Graphiques',
    'Notifications',
    'Mes Cultures',
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            _titles[navController.selectedIndex.value],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green[700],
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            // Menu profil
            PopupMenuButton<String>(
              icon: CircleAvatar(
                backgroundColor: Colors.green[900],
                child: Text(
                  'AS',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onSelected: (value) {
                if (value == 'profile') {
                  // Navigation profil
                } else if (value == 'settings') {
                  // Navigation parametres
                } else if (value == 'logout') {
                  // Deconnexion
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: 'profile',
                  child: Row(
                    children: [
                      Icon(Icons.person, size: 20),
                      SizedBox(width: 12),
                      Text('Profil'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'settings',
                  child: Row(
                    children: [
                      Icon(Icons.settings, size: 20),
                      SizedBox(width: 12),
                      Text('Parametres'),
                    ],
                  ),
                ),
                PopupMenuDivider(),
                PopupMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, size: 20, color: Colors.red),
                      SizedBox(width: 12),
                      Text(
                        'Deconnexion',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: _screens[navController.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navController.selectedIndex.value,
          onTap: (index) => navController.changePage(index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.green[700],
          unselectedItemColor: Colors.grey[600],
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 8,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              activeIcon: Icon(Icons.dashboard, size: 28),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              activeIcon: Icon(Icons.trending_up, size: 28),
              label: 'Graphiques',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(Icons.notifications),
                  Positioned(
                    right: -6,
                    top: -4,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              activeIcon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(Icons.notifications, size: 28),
                  Positioned(
                    right: -6,
                    top: -4,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              label: 'Alertes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.eco),
              activeIcon: Icon(Icons.eco, size: 28),
              label: 'Cultures',
            ),
          ],
        ),
      ),
    );
  }
}
