/*
import 'package:json_annotation/json_annotation.dart';
/// list : [{"location":"Current location","city":"Dhaka","status":"Thunder","temp":"20°C"},{"location":"United States","city":"California","status":"Clear","temp":"06°C"},{"location":"China","city":"Beijing","status":"Mostly Sunny","temp":"05°C"},{"location":"Russia","city":"Moscow","status":"Cloudy","temp":"-04°C"}]

class ModelClass {
  ModelClass({
      List<List>? list,}){
    _list = list;
}

  ModelClass.fromJson(dynamic json) {
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list?.add(List.fromJson(v));
      });
    }
  }
  List<List>? _list;

  List<List>? get list => _list;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_list != null) {
      map['list'] = _list?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// location : "Current location"
/// city : "Dhaka"
/// status : "Thunder"
/// temp : "20°C"

class List {
  List({
      String? location, 
      String? city, 
      String? status, 
      String? temp,}){
    _location = location;
    _city = city;
    _status = status;
    _temp = temp;
}

  List.fromJson(dynamic json) {
    _location = json['location'];
    _city = json['city'];
    _status = json['status'];
    _temp = json['temp'];
  }
  String? _location;
  String? _city;
  String? _status;
  String? _temp;

  String? get location => _location;
  String? get city => _city;
  String? get status => _status;
  String? get temp => _temp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['location'] = _location;
    map['city'] = _city;
    map['status'] = _status;
    map['temp'] = _temp;
    return map;
  }

}
*/
