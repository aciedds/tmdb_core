import 'package:tmdb_core/domain/repository/film_repository.dart';
import 'package:tmdb_core/state/data_state/data_state.dart';

class RemoveFromWatchlistUc {
  final FilmRepository _filmRepository;

  RemoveFromWatchlistUc(this._filmRepository);

  Future<DataState<bool>> call(int id) async =>
      await _filmRepository.removeFromWatchlist(id);
}
