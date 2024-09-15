import 'package:flutter/material.dart';
import 'package:persist_data_example_sqlite/core/theme_extensions.dart';

class Navdrawer extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;
  final VoidCallback
      deleteAllBlogs; //Used here as it is void (takes no parameters)

  const Navdrawer({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.deleteAllBlogs,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FractionallySizedBox(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer header
            Container(
              height: 100, // Height for the header.
              decoration: const BoxDecoration(color: spotifyGreen),
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      15, 0, 0, 15), // Padding for positioning the title.
                  child: Text(
                    'Additional',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Features'),
            ),
            ListTile(
              title:
                  const Text('Delete All Blogs'), // Option to delete all blogs.
              leading: const Icon(Icons.delete), // Trash icon.
              onTap: () {
                Navigator.pop(context); // Close the drawer.
                deleteAllBlogs(); // Delete all blogs using the passed callback.
              },
            ),
            const Divider(),
            // Light/Dark mode switch
            ListTile(
              title: const Text('Dark Mode'), // Toggle dark mode.
              trailing: Switch(
                value: isDarkMode, // Show current theme mode.
                onChanged:
                    onThemeChanged, // Toggle between light and dark modes.
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.waving_hand), // Hand wave icon.
              title: const Text('Hi I\'m Felix'),
              subtitle: const Text(
                  'A Full Stack Software Developer'), // About section.
            ),
          ],
        ),
      ),
    );
  }
}
