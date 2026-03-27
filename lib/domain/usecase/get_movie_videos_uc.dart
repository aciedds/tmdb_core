
import 'package:tmdb_core/domain/entity/video_entity/video_entity.dart';
import 'package:tmdb_core/domain/repository/film_repository.dart';
import 'package:tmdb_core/state/data_state/data_state.dart';

class GetMovieVideosUc {
  final FilmRepository _filmRepository;

  GetMovieVideosUc(this._filmRepository);

  Future<DataState<List<VideoEntity>>> call({required int id}) async {
    return await _filmRepository.getMovieVideos(id: id);
  }
}
