
import 'package:tmdb_core/domain/repository/film_repository.dart';

class GetHasExistInWatchlistUc {
  final FilmRepository _filmRepository;

  GetHasExistInWatchlistUc(this._filmRepository);

  bool call(int id) {
    final result = _filmRepository.isOnWatchlist(id);
    return result.when(
      success: (data) => data,
      error: (message, data, exception, stackTrace, statusCode) => false,
    );
  }
}
