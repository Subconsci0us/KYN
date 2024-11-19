import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {


  // Sample event data
  final List<Map<String, String>> events = [
    {
      'title': 'A virtual evening of smooth jazz',
      'date': '1st May, Sat - 2:00 PM',
      'image': 'assets/images/logo.png', // Replace with your image asset or network image
    },
    {
      'title': "Jo malone London's mother's day",
      'date': '1st May, Sat - 2:00 PM',
      'image': 'assets/images/logo.png',
    },
    {
      'title': "Women's leadership conference",
      'date': '1st May, Sat - 2:00 PM',
      'image': 'assets/images/logo.png',
    },
    {
      'title': 'International kids safe parents night out',
      'date': '1st May, Sat - 2:00 PM',
      'image': 'assets/images/logo.png',
    },
    {
      'title': 'International gala music festival',
      'date': '1st May, Sat - 2:00 PM',
      'image': 'assets/images/logo.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Events'),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.transparent),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                border: InputBorder.none,
                suffixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.tune, color: Colors.black),
                ),
              ),
            ),
          ),
          // Event List
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Image.asset(
                      event['image']!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(event['title']!),
                    subtitle: Text(event['date']!),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to event details page (optional)
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      
    );
  }
}

