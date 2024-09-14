class BookEntity {
  final String? bookId;
  final String? image;
  final String? title;
  final String? authorName;
  final num? pageCount;

  BookEntity(
      {required this.bookId,
      required this.image,
      required this.title,
      required this.authorName,
      required this.pageCount});
}
