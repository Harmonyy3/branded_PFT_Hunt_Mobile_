import 'package:flutter/material.dart';
import '../screens/welcome_screen.dart';
import '../screens/map_screen.dart';
import '../screens/help_screen.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({super.key});

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _selectedIndex = 0;

  //the order of the screens
  final List<Widget> _screens = [
    const WelcomeScreen(),
    const Mapscreen(),
    const Helpscreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: Color(0xFF461D7C)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map, color: Color(0xFF461D7C)),
            label: 'PFT Map',
          ),
BottomNavigationBarItem(
            icon: Icon(Icons.help_outline, color: Color(0xFF461D7C)),
            label: 'Instruction',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF461D7C),
        onTap: _onItemTapped,
      ),
    );
  }
}
