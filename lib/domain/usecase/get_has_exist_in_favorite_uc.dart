
import 'package:tmdb_core/domain/repository/film_repository.dart';

class GetHasExistInFavoriteUc {
  final FilmRepository _filmRepository;

  GetHasExistInFavoriteUc(this._filmRepository);

  bool call(int id) {
    final result = _filmRepository.isOnFavorite(id);
    return result.when(
      success: (data) => data,
      error: (message, data, exception, stackTrace, statusCode) => false,
    );
  }
}
