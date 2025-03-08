import 'package:flutter/material.dart';
import 'package:gluco_mate/ui/drawer/settings/settings_screen.dart';
import 'package:gluco_mate/ui/theme/colors.dart';
import 'package:gluco_mate/ui/theme/style.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: whiteColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Gluco Mate",
                  style: largeTextStyle1,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.file_copy),
            title: Text(
              'Reports',
              style: titleTextStyle,
            ),
            onTap: () {
              Navigator.pop(context); // Close Drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(
              'Settings',
              style: titleTextStyle,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              ); // Close Drawer
            },
          ),
        ],
      ),
    );
  }
}
