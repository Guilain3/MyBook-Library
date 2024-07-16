class BkMdl {
  final int id;
  final String title;
  final String author;
  final int rating;
  final bool isRead;

  BkMdl({required this.id, required this.title, required this.author, required this.rating, required this.isRead});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'rating': rating,
      'isRead': isRead ? 1 : 0,
    };
  }
}
