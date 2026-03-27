import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_entity.freezed.dart';

@freezed
class VideoEntity with _$VideoEntity {
  factory VideoEntity({
    required String id,
    required String key,
    required String name,
    required String site,
    required String type,
    required bool official,
    required int size,
    String? publishedAt,
  }) = _VideoEntity;
}
