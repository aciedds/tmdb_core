import 'package:tmdb_core/data/model/video_model/video_model.dart';
import 'package:tmdb_core/domain/entity/video_entity/video_entity.dart';

class VideoMapper {
  VideoEntity mapModelToEntity(VideoModel videoModel) {
    return VideoEntity(
      id: videoModel.id ?? '',
      key: videoModel.key ?? '',
      name: videoModel.name ?? '',
      site: videoModel.site ?? '',
      type: videoModel.type ?? '',
      official: videoModel.official ?? false,
      size: videoModel.size ?? 0,
      publishedAt: videoModel.publishedAt,
    );
  }

  List<VideoEntity> mapModelToEntityList(List<VideoModel> videoModels) {
    return videoModels
        .map((videoModel) => mapModelToEntity(videoModel))
        .toList();
  }

  VideoModel mapEntityToModel(VideoEntity videoEntity) {
    return VideoModel(
      id: videoEntity.id,
      key: videoEntity.key,
      name: videoEntity.name,
      site: videoEntity.site,
      type: videoEntity.type,
      official: videoEntity.official,
      size: videoEntity.size,
      publishedAt: videoEntity.publishedAt,
    );
  }

  List<VideoModel> mapEntityToModelList(List<VideoEntity> videoEntities) {
    return videoEntities
        .map((videoEntity) => mapEntityToModel(videoEntity))
        .toList();
  }
}
