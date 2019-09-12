// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version.dart';

// **************************************************************************
// JsonSerializableGenerator
//flutter pub run build_runner build
// **************************************************************************

Version _$fromJson(Map<String, dynamic> json) {
  return Version()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..versionCode = json['versionCode'] as int
    ..downloadUrl = json['downloadUrl'] as String
    ..idiomCount = json['idiomCount'] as int
    ..dataUpdateTime = json['dataUpdateTime'] == null
        ? null
        : BmobDate.fromJson(json['dataUpdateTime'] as Map<String, dynamic>);
}

Map<String, dynamic> _$toJson(Version instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'versionCode': instance.versionCode,
      'downloadUrl': instance.downloadUrl,
      'idiomCount': instance.idiomCount,
      'dataUpdateTime': instance.dataUpdateTime,
    };
