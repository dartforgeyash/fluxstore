import 'package:flutter/material.dart';

class DriverAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isOnline;
  final ValueChanged<bool> onToggleStatus;
  final List<Widget>? actions;
  const DriverAppBar({
    super.key,
    required this.title,
    required this.isOnline,
    required this.onToggleStatus,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      actions:
          actions ??
          [
            // Driver Online/Offline Toggle
            Row(
              children: [
                Text(
                  isOnline ? "ONLINE" : "OFFLINE",
                  style: TextStyle(
                    color: isOnline ? Colors.green : Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(value: isOnline, onChanged: onToggleStatus, activeThumbColor: Colors.green),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.black),
              onPressed: () {},
            ),
          ],
    );
  }

  // This is required when implementing PreferredSizeWidget
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
