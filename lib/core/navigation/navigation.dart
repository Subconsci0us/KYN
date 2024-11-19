import 'package:flutter/material.dart';
import 'package:kyn/features/event/event_page.dart';
import 'package:kyn/features/home/home_page.dart';
import 'package:kyn/features/maps/map_page.dart';
import 'package:kyn/features/profile/profile_page.dart'; // Adjust this import to match your project's structure


class NavigationWithFAB extends StatefulWidget {
  @override
  _NavigationWithFABState createState() => _NavigationWithFABState();
}

class _NavigationWithFABState extends State<NavigationWithFAB> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex, // Make sure this references the current page index
        children:  [
         const HomePage(),
          EventsPage(),
          MapPage(),
         const ProfilePage(),
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Define action for the FAB
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
       resizeToAvoidBottomInset: false,
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today),
            label: 'Events',
          ),
          NavigationDestination(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedIndex: _currentIndex,
        onDestinationSelected: _onItemTapped,
      ),
    );
  }
}


