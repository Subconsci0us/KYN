import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
        centerTitle: true,
        title: const Center(
          child: Text('Settings'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "assets/images/logo.png", // Corrected the image property usage
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text("Shayan"),
                    const Text("e@gmail.com"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              Menu(
                title: 'Edit Profile',
                description: 'Update your profile',
                endIcon: Icons.keyboard_arrow_right,
                onpress: () {},
                icon: Icons.edit,
              ),
              const SizedBox(height: 5),
              Menu(
                title: 'My Activity',
                description: 'View your Activity History',
                endIcon: Icons.keyboard_arrow_right,
                onpress: () {},
                icon: Icons.menu,
              ),
              const SizedBox(height: 5),
              Menu(
                title: 'App Settings',
                description: 'Adjust your App Settings',
                endIcon: Icons.keyboard_arrow_right,
                onpress: () {},
                icon: Icons.settings,
              ),
              const Divider(),
              const SizedBox(height: 5),
              Menu(
                title: 'Invite a Friend',
                description: 'Invite your friends to join',
                endIcon: Icons.keyboard_arrow_right,
                onpress: () {},
                icon: Icons.person_add,
              ),
              Menu(
                title: 'Suggest a change',
                description: 'Help improve the app',
                endIcon: Icons.keyboard_arrow_right,
                onpress: () {},
                icon: Icons.settings_suggest_outlined,
              ),
              const SizedBox(height: 5),
              Menu(
                title: 'Help',
                description: 'Get support',
                endIcon: Icons.keyboard_arrow_right,
                onpress: () {},
                icon: Icons.help,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({
    required this.title,
    required this.description,
    required this.icon,
    required this.onpress,
    required this.endIcon,
    this.textStyle,
    super.key,
  });

  final String title;
  final String description;
  final TextStyle? textStyle;

  final IconData icon;
  final VoidCallback onpress;
  final IconData endIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              icon,
              size: 28,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textStyle?.copyWith(fontSize: 18),
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
          trailing: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(endIcon, size: 28),
          ),
        ),
      ),
    );
  }
}
