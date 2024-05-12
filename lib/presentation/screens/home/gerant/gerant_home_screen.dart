import 'package:flutter/material.dart';
import 'package:resto/presentation/screens/home/gerant/gerant_dashbord_widget.dart';
import 'package:resto/presentation/screens/home/gerant/gerant_profile_widget.dart';
import 'package:resto/presentation/screens/home/gerant/gerant_tabels_widgets.dart';
import 'package:resto/presentation/screens/home/gerant/gerant_users_widget.dart';

class GerantHomeScreen extends StatefulWidget {
  const GerantHomeScreen({super.key});

  @override
  State<GerantHomeScreen> createState() => _GerantHomeScreenState();
}

class _GerantHomeScreenState extends State<GerantHomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> screens = [
    GerantDashbordWidget(),
    GerantUsersWidget(),
    GerantTabelsWidget(),
    GerantProfileWidget(),
  ];
  final List<String> titles = const ["Dashbord", "Users", "Tabels", "Profile"];
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
                _buildNavBarItem(Icons.person, 'Users', 1),
                _buildNavBarItem(Icons.padding, 'Tabels', 2),
                _buildNavBarItem(Icons.person_off_outlined, 'Profile', 3),
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
