
import 'package:tmdb_core/domain/entity/genre_entity/genre_entity.dart';
import 'package:tmdb_core/domain/repository/film_repository.dart';
import 'package:tmdb_core/state/data_state/data_state.dart';
  
class GetMovieGenresUc {
  final FilmRepository _filmRepository;

  GetMovieGenresUc(this._filmRepository);

  Future<DataState<List<GenreEntity>>> call() async {
    return await _filmRepository.getMovieGenres();
  }
}
