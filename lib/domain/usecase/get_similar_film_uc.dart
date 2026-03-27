
import 'package:tmdb_core/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_core/domain/repository/film_repository.dart';
import 'package:tmdb_core/state/data_state/data_state.dart';

class GetSimilarFilmUc {
  final FilmRepository _filmRepository;

  GetSimilarFilmUc(this._filmRepository);

  Future<DataState<List<FilmEntity>>> call({
    required int id,
    int page = 1,
  }) async {
    return await _filmRepository.getSimilarFilms(id: id, page: page);
  }
}
