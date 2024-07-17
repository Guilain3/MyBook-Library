import 'package:flutter/material.dart';
import '../data/models/book_model.dart';

class BookDetailScreen extends StatelessWidget {
  final BkMdl? book;

  BookDetailScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book?.title ?? 'Book Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: book != null
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Author: ${book!.author}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Rating: ${book!.rating}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Read: ${book!.isRead ? "Yes" : "No"}', style: TextStyle(fontSize: 18)),
          ],
        )
            : Center(
          child: Text('No book selected'),
        ),
      ),
    );
  }
}
