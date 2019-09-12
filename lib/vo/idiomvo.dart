import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'idiom.g.dart';

@JsonSerializable()
class Idiom extends BmobObject{
   String derivation;//出处
   String example;//示例
   String explanation;//解释
   String pinyin;//拼音
   String word;//成语
   String abbreviation;//缩写
   Idiom();
  @override
  Map getParams() {
    return toJson();
  }
   factory Idiom.fromJson(Map<String, dynamic> json) =>
       _$IdiomVoFromJson(json);



   //此处与类名一致，由指令自动生成代码
   Map<String, dynamic> toJson() => _$IdiomVoToJson(this);
}