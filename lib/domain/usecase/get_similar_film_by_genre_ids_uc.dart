import 'package:tmdb_core/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_core/domain/repository/film_repository.dart';
import 'package:tmdb_core/state/data_state/data_state.dart';

class GetSimilarFilmByGenresUc {
  final FilmRepository _filmRepository;

  GetSimilarFilmByGenresUc(this._filmRepository);

  Future<DataState<List<FilmEntity>>> call({
    required List<int> genreIds,
    int page = 1,
  }) async {
    return await _filmRepository.getSimilarFilmsBySameGenreIds(
      genreIds: genreIds,
      page: page,
    );
  }
}
