import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/book_state.dart';
import '../components/book_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bkState = Provider.of<BkSt>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Library'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text(
                'View All Books',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.pop(context);
                // Handle the view all books action
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text(
                'Shared Preferences',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.pop(context);

              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.purple[100],
        ),
        child: ListView.builder(
          itemCount: bkState.books.length,
          itemBuilder: (context, index) {
            return BkCrd(book: bkState.books[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add_edit'),
        child: Icon(Icons.add),
        backgroundColor: Colors.purple[200],
      ),
    );
  }
}
