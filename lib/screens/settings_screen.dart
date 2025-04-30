import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: const [
          SwitchListTile(
            title: Text('Enable Task Reminders'),
            value: true, onChanged: null,
          ),
          SwitchListTile(
            title: Text('Enable Rating Notifications'),
            value: true, onChanged: null,
          ),
        ],
      ),
    );
  }
}
