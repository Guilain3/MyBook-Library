import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../state/book_state.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppSt>(context);
    final bkState = Provider.of<BkSt>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            SwitchListTile(
              title: Text('Dark Mode'),
              value: appState.isDarkMode,
              onChanged: (value) {
                appState.setTheme(value);
              },
            ),
            ListTile(
              title: Text('Sort Order'),
              trailing: DropdownButton<String>(
                value: appState.sortOrder,
                onChanged: (value) {
                  appState.setSortOrder(value!);
                  bkState.setSortOrder(value);
                },
                items: ['title', 'author', 'rating'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SwitchListTile(
              title: Text('Show Read Books'),
              value: bkState.showRead,
              onChanged: (value) {
                bkState.toggleShowRead(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
