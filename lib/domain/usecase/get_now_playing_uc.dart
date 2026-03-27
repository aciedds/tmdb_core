
import 'package:tmdb_core/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_core/domain/repository/film_repository.dart';
import 'package:tmdb_core/state/data_state/data_state.dart';

class GetNowPlayingUc {
  final FilmRepository _filmRepository;

  GetNowPlayingUc(this._filmRepository);

  Future<DataState<List<FilmEntity>>> call({int page = 1}) async {
    return await _filmRepository.getNowPlayingFilms(page: page);
  }
}
