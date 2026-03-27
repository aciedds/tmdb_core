import 'package:tmdb_core/data/model/genre_model/genre_model.dart';
import 'package:tmdb_core/domain/entity/genre_entity/genre_entity.dart';

class GenreMapper {
  List<GenreEntity> mapModelToEntity(List<GenreModel> genreModels) {
    return genreModels
        .map((e) => GenreEntity(id: e.id ?? 0, name: e.name ?? ''))
        .toList();
  }

  List<GenreModel> mapEntityToModel(List<GenreEntity> genreEntities) {
    return genreEntities
        .map((e) => GenreModel(id: e.id, name: e.name))
        .toList();
  }
}
