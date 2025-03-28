// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import '../../../src/data/models/note_dto.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 4002907414117788386),
      name: 'NoteDto',
      lastPropertyId: const obx_int.IdUid(8, 2667460658028468818),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 7897856024455966361),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 1497354730739940227),
            name: 'title',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 7199025730328670336),
            name: 'shortDescription',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 5075190071924158864),
            name: 'content',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 5481784466053967912),
            name: 'leadingIcon',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 7258641598952706259),
            name: 'tags',
            type: 30,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 1656213982265210457),
            name: 'createdAt',
            type: 10,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(8, 2667460658028468818),
            name: 'alarmAt',
            type: 10,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(1, 4002907414117788386),
      lastIndexId: const obx_int.IdUid(0, 0),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    NoteDto: obx_int.EntityDefinition<NoteDto>(
        model: _entities[0],
        toOneRelations: (NoteDto object) => [],
        toManyRelations: (NoteDto object) => {},
        getId: (NoteDto object) => object.id,
        setId: (NoteDto object, int id) {
          object.id = id;
        },
        objectToFB: (NoteDto object, fb.Builder fbb) {
          final titleOffset = fbb.writeString(object.title);
          final shortDescriptionOffset =
              fbb.writeString(object.shortDescription);
          final contentOffset = fbb.writeString(object.content);
          final leadingIconOffset = fbb.writeString(object.leadingIcon);
          final tagsOffset = object.tags == null
              ? null
              : fbb.writeList(
                  object.tags!.map(fbb.writeString).toList(growable: false));
          fbb.startTable(9);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, titleOffset);
          fbb.addOffset(2, shortDescriptionOffset);
          fbb.addOffset(3, contentOffset);
          fbb.addOffset(4, leadingIconOffset);
          fbb.addOffset(5, tagsOffset);
          fbb.addInt64(6, object.createdAt.millisecondsSinceEpoch);
          fbb.addInt64(7, object.alarmAt?.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final alarmAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 18);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final titleParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final shortDescriptionParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, '');
          final contentParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 10, '');
          final leadingIconParam =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 12, '');
          final tagsParam = const fb.ListReader<String>(
                  fb.StringReader(asciiOptimization: true),
                  lazy: false)
              .vTableGetNullable(buffer, rootOffset, 14);
          final createdAtParam = DateTime.fromMillisecondsSinceEpoch(
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 16, 0));
          final alarmAtParam = alarmAtValue == null
              ? null
              : DateTime.fromMillisecondsSinceEpoch(alarmAtValue);
          final object = NoteDto(
              id: idParam,
              title: titleParam,
              shortDescription: shortDescriptionParam,
              content: contentParam,
              leadingIcon: leadingIconParam,
              tags: tagsParam,
              createdAt: createdAtParam,
              alarmAt: alarmAtParam);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [NoteDto] entity fields to define ObjectBox queries.
class NoteDto_ {
  /// See [NoteDto.id].
  static final id =
      obx.QueryIntegerProperty<NoteDto>(_entities[0].properties[0]);

  /// See [NoteDto.title].
  static final title =
      obx.QueryStringProperty<NoteDto>(_entities[0].properties[1]);

  /// See [NoteDto.shortDescription].
  static final shortDescription =
      obx.QueryStringProperty<NoteDto>(_entities[0].properties[2]);

  /// See [NoteDto.content].
  static final content =
      obx.QueryStringProperty<NoteDto>(_entities[0].properties[3]);

  /// See [NoteDto.leadingIcon].
  static final leadingIcon =
      obx.QueryStringProperty<NoteDto>(_entities[0].properties[4]);

  /// See [NoteDto.tags].
  static final tags =
      obx.QueryStringVectorProperty<NoteDto>(_entities[0].properties[5]);

  /// See [NoteDto.createdAt].
  static final createdAt =
      obx.QueryDateProperty<NoteDto>(_entities[0].properties[6]);

  /// See [NoteDto.alarmAt].
  static final alarmAt =
      obx.QueryDateProperty<NoteDto>(_entities[0].properties[7]);
}
