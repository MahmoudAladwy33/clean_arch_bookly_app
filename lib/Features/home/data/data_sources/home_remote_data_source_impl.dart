import 'package:bookly/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:bookly/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/constants.dart';
import 'package:bookly/core/utils/api_service.dart';
import 'package:bookly/core/utils/functions/save_books.dart';

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl(this.apiService);
  @override
  Future<List<BookEntity>> fetchFeaturedBooks() async {
    var data = await apiService.get(
        endPoint: 'volumes?&filtering=free_ebooks&Sorting=Newst&q=flutter');
    List<BookEntity> books = getBooksList(data);
    saveBooksData(books, kFeturedbox);
    return books;
  }

  @override
  Future<List<BookEntity>> fetchNewestBooks() async {
    var data =
        await apiService.get(endPoint: 'volumes?Filtering=free-ebooks&q=dart');
    List<BookEntity> books = getBooksList(data);
    saveBooksData(books, kNewestbox);
    return books;
  }

  List<BookEntity> getBooksList(Map<String, dynamic> data) {
    List<BookEntity> books = [];
    for (var bookMap in data['items']) {
      books.add(BookModel.fromJson(bookMap));
    }
    return books;
  }
}
