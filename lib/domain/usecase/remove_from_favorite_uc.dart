
import 'package:tmdb_core/domain/repository/film_repository.dart';
import 'package:tmdb_core/state/data_state/data_state.dart';

class RemoveFromFavoriteUc {
  final FilmRepository _filmRepository;

  RemoveFromFavoriteUc(this._filmRepository);

  Future<DataState<bool>> call(int id) async =>
      await _filmRepository.removeFromFavorite(id);
}
