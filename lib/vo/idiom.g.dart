
part of 'idiomvo.dart';

Idiom _$IdiomVoFromJson(Map<String, dynamic> json) {
  return Idiom()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
//    ..ACL = json['ACL'] as Map<String, dynamic>
    ..word=json['word'] as String
    ..pinyin=json['pinyin'] as String
    ..explanation=json['explanation'] as String
    ..abbreviation=json['abbreviation'] as String
    ..example=json['example'] as String
    ..derivation=json['derivation'] as String
  ;
}


  Map<String, dynamic> _$IdiomVoToJson(Idiom instance) => <String, dynamic>{
    'createdAt': instance.createdAt,
    'updatedAt': instance.updatedAt,
    'objectId': instance.objectId,
//    'ACL': instance.ACL,
    'word':instance.word,
    'pinyin':instance.pinyin,
    'explanation':instance.explanation,
    'abbreviation':instance.abbreviation,
    'example':instance.example,
    'derivation':instance.derivation
  };