
import 'package:tmdb_core/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_core/domain/repository/film_repository.dart';
import 'package:tmdb_core/state/data_state/data_state.dart';
  
class AddWatchlistUc {
  final FilmRepository _filmRepository;

  AddWatchlistUc(this._filmRepository);

  Future<DataState<bool>> call({required FilmEntity data}) async {
    return await _filmRepository.addWatchlist(data: data);
  }
}
