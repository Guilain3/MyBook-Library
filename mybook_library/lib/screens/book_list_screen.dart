import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/book_state.dart';
import '../data/models/book_model.dart';
import 'book_detail_screen.dart';
import 'settings_screen.dart';

class BookListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookState = Provider.of<BkSt>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Book List'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: BookSearchDelegate());
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: bookState.filteredBooks.length,
        itemBuilder: (context, index) {
          BkMdl book = bookState.filteredBooks[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text(book.author),
            trailing: Icon(
              book.isRead ? Icons.check_box : Icons.check_box_outline_blank,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailScreen(book: book),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BookSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final bookState = Provider.of<BkSt>(context, listen: false);
    bookState.searchBooks(query);

    return Consumer<BkSt>(
      builder: (context, state, child) {
        return ListView.builder(
          itemCount: state.filteredBooks.length,
          itemBuilder: (context, index) {
            BkMdl book = state.filteredBooks[index];
            return ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              trailing: Icon(
                book.isRead ? Icons.check_box : Icons.check_box_outline_blank,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailScreen(book: book),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final bookState = Provider.of<BkSt>(context, listen: false);
    bookState.searchBooks(query);

    return Consumer<BkSt>(
      builder: (context, state, child) {
        return ListView.builder(
          itemCount: state.filteredBooks.length,
          itemBuilder: (context, index) {
            BkMdl book = state.filteredBooks[index];
            return ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              trailing: Icon(
                book.isRead ? Icons.check_box : Icons.check_box_outline_blank,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailScreen(book: book),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
