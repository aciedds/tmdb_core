
import 'package:tmdb_core/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_core/domain/repository/film_repository.dart';
import 'package:tmdb_core/state/data_state/data_state.dart';

class GetFavoriteUc {
  final FilmRepository _filmRepository;

  GetFavoriteUc(this._filmRepository);

  Future<DataState<List<FilmEntity>>> call() async {
    return await _filmRepository.getListFavorite();
  }
}
