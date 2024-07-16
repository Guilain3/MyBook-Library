import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/book_state.dart';
import '../data/models/book_model.dart';
import '../components/rating_star.dart';

class AddEditScreen extends StatefulWidget {
  final BkMdl? book;

  AddEditScreen({this.book});

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title, _author;
  late int _rating;
  late bool _isRead;

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      _title = widget.book!.title;
      _author = widget.book!.author;
      _rating = widget.book!.rating;
      _isRead = widget.book!.isRead;
    } else {
      _title = '';
      _author = '';
      _rating = 0;
      _isRead = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bkState = Provider.of<BkSt>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book == null ? 'Add Book' : 'Edit Book'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
              ),
              TextFormField(
                initialValue: _author,
                decoration: InputDecoration(labelText: 'Author'),
                onSaved: (value) => _author = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter an author' : null,
              ),
              RatingStars(
                rating: _rating,
                onRatingChanged: (value) {
                  setState(() {
                    _rating = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Read'),
                value: _isRead,
                onChanged: (value) {
                  setState(() {
                    _isRead = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.book == null) {
                      bkState.addBook(BkMdl(
                        id: DateTime.now().millisecondsSinceEpoch,
                        title: _title,
                        author: _author,
                        rating: _rating,
                        isRead: _isRead,
                      ));
                    } else {
                      bkState.editBook(BkMdl(
                        id: widget.book!.id,
                        title: _title,
                        author: _author,
                        rating: _rating,
                        isRead: _isRead,
                      ));
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.book == null ? 'Add' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
