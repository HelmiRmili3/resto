import 'package:flutter/material.dart';
import 'package:resto/presentation/screens/home/chef/chef_dashbord_widget.dart';
import 'package:resto/presentation/screens/home/chef/chef_plats_widget.dart';
import 'package:resto/presentation/screens/home/chef/chef_profile_widget.dart';

class ChefHomeScreen extends StatefulWidget {
  const ChefHomeScreen({super.key});

  @override
  State<ChefHomeScreen> createState() => _ChefHomeScreenState();
}

class _ChefHomeScreenState extends State<ChefHomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> screens = [
    ChefDashborWidget(),
    ChefPlatsWidget(),
    ChefProfileWidget()
  ];
  final List<String> titles = const ["Dashbord", "Plats", "Profile"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[_selectedIndex],
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: screens[_selectedIndex],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _buildNavBarItem(Icons.home, 'Dashbord', 0),
                _buildNavBarItem(Icons.food_bank, 'Plats', 1),
                _buildNavBarItem(Icons.person, 'Profile', 2)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBarItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _selectedIndex == index ? Colors.black : Colors.grey[400],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color:
                    _selectedIndex == index ? Colors.black : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
