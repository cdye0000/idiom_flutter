import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:data_plugin/bmob/type/bmob_date.dart';
import 'package:json_annotation/json_annotation.dart';
part 'version.g.dart';
@JsonSerializable()
class Version extends BmobObject{
  int versionCode;
  String downloadUrl;
  int idiomCount;
  BmobDate dataUpdateTime;
  Version();
  @override
  Map getParams() {
    return toJson();
  }
  factory Version.fromJson(Map<String,dynamic> json)=>_$fromJson(json);

  Map<String,dynamic> toJson()=>_$toJson(this);


}