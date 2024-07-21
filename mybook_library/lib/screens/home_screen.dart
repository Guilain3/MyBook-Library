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
        title: Text('Personal Book Library'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
              ),
              child: Text(
                'My Library',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.book, color: Theme.of(context).iconTheme.color),
              title: Text(
                'View All Books',
                style: TextStyle(fontSize: 18, color: Theme.of(context).textTheme.bodyMedium?.color),
              ),
              onTap: () {
                Navigator.pop(context);
                bkState.resetFilters(); // Reset filters to view all books
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Theme.of(context).iconTheme.color),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 18, color: Theme.of(context).textTheme.bodyMedium?.color),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => bkState.searchBooks(value),
                decoration: InputDecoration(
                  labelText: 'Search by title or author',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: bkState.filteredBooks.length,
                itemBuilder: (context, index) {
                  return BkCrd(book: bkState.filteredBooks[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add_edit'),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
