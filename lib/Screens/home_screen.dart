import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_scan/Screens/profile_screen.dart';
import 'package:food_scan/Screens/qr_screen.dart';
import 'package:food_scan/Widgets/expandable_fab.dart';
import 'add_food_screen.dart';
import 'dashboard_screen.dart';
import 'history_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [DashboardScreen(), AddFoodScreen(), HistoryScreen(), ProfileScreen(), QRScreen()];

  final List<String> _screenTitles = ['Dashboard', 'Add Food', 'History', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_screenTitles[_selectedIndex]), backgroundColor: Colors.green, elevation: 2),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade700, Colors.green.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 3;
                        });
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 40, color: Colors.green.shade700),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Calorie Tracker',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('Stay healthy!', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  ],
                ),
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(icon: Icons.dashboard, title: 'Dashboard', index: 0),
                  _buildDrawerItem(icon: Icons.add_circle, title: 'Add Food', index: 1),
                  _buildDrawerItem(icon: Icons.history, title: 'History', index: 2),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.grey.shade600),
                    title: Text('Settings'),
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: Navigate to settings screen
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Settings coming soon!')));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info, color: Colors.grey.shade600),
                    title: Text('About'),
                    onTap: () {
                      Navigator.pop(context);
                      _showAboutDialog();
                    },
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Version 1.0.0',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(child: _screens[_selectedIndex]),
      floatingActionButton:
          _selectedIndex != 1
              ? ExpandableFab(
                onManualAdd: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                onBarcodeScann: () {
                  _handleBarcodeScann();
                },
                onTextScan: () {
                  _handleTextScan();
                },
              )
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _handleBarcodeScann() {
    setState(() {
      _selectedIndex = 4;
    });
    Navigator.pop(context);
  }

  void _handleTextScan() {
    // TODO: Implement text scanning functionality
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Text scanning coming soon!'), backgroundColor: Colors.purple));
  }

  Widget _buildDrawerItem({required IconData icon, required String title, required int index}) {
    final isSelected = _selectedIndex == index;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? Colors.green.shade50 : Colors.transparent,
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? Colors.green.shade700 : Colors.grey.shade600),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.green.shade700 : Colors.grey.shade800,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('About Calorie Tracker'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('A simple and effective calorie tracking app to help you maintain a healthy lifestyle.'),
              SizedBox(height: 16),
              Text('Features:'),
              Text('• Track daily calorie intake'),
              Text('• Set daily goals'),
              Text('• View eating history'),
              Text('• Categorize meals'),
            ],
          ),
          actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('OK'))],
        );
      },
    );
  }
}
