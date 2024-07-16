import 'package:flutter/material.dart';
import '../data/models/book_model.dart';
import '../state/book_state.dart';
import 'package:provider/provider.dart';

class BkCrd extends StatelessWidget {
  final BkMdl book;

  BkCrd({required this.book});

  @override
  Widget build(BuildContext context) {
    final bkState = Provider.of<BkSt>(context);

    return Card(
      child: ListTile(
        title: Text(book.title),
        subtitle: Text(book.author),
        trailing: PopupMenuButton<String>(
          onSelected: (String value) {
            switch (value) {
              case 'Edit':
                Navigator.pushNamed(context, '/add_edit', arguments: book);
                break;
              case 'Delete':
                bkState.deleteBook(book.id);
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            return {'Edit', 'Delete'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
