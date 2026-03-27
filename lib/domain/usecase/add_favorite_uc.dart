
import 'package:tmdb_core/domain/entity/film_entity/film_entity.dart';
import 'package:tmdb_core/domain/repository/film_repository.dart';
import 'package:tmdb_core/state/data_state/data_state.dart';

class AddFavoriteUc {
  final FilmRepository _filmRepository;

  AddFavoriteUc(this._filmRepository);

  Future<DataState<bool>> call({required FilmEntity data}) async {
    return await _filmRepository.addFavorite(data: data);
  }
}
