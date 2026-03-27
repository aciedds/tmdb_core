import 'package:hive/hive.dart';
import 'package:tmdb_core/data/model/genre_model/genre_model.dart';

part 'genre_model_adapter.g.dart';

@HiveType(typeId: 1)
class GenreModelAdapter extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  GenreModelAdapter({
    this.id,
    this.name,
  });

  factory GenreModelAdapter.fromGenreModel(GenreModel genre) {
    return GenreModelAdapter(
      id: genre.id,
      name: genre.name,
    );
  }

  GenreModel toGenreModel() {
    return GenreModel(
      id: id,
      name: name,
    );
  }
}
