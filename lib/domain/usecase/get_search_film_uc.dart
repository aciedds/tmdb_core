
import 'package:tmdb_core/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_core/domain/repository/film_repository.dart';
import 'package:tmdb_core/state/data_state/data_state.dart';
  
class GetSearchFilmUc {
  final FilmRepository _filmRepository;

  GetSearchFilmUc(this._filmRepository);

  Future<DataState<List<FilmEntity>>> call(String query) {
    return _filmRepository.searchFilms(query: query);
  }
}
