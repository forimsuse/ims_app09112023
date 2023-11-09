import '../../utils/bytes_utils.dart';

class SettingModel{

  bool? charge85;
  int? tagId;
  SettingModel.fromBytesUtil(BytesUtil bytesUtil){
    charge85 = bytesUtil.bytes[2] == 1 ? true : false;
    tagId = bytesUtil.getFrom32bit(3);
  }

  SettingModel.fromContinuousSample(int chargeMax,this.tagId){
    charge85 = chargeMax == 1 ? true : false;
  }

  SettingModel.fromJson(Map<String,dynamic> json){
    charge85 = json["charge85"];
    tagId = json["tagId"];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> map = {};
    map["charge85"] = charge85;
    map["tagId"] = tagId;
    return map;
  }

}