import 'dart:convert';

import 'package:unidwell_finder/core/constatnts/options_list.dart';

class InstitutionsModel {
  String id;
  String name;
  String location;
  double lat;
  double long;
  InstitutionsModel({
    required this.id,
    required this.name,
    required this.location,
    required this.lat,
    required this.long,
  });

  InstitutionsModel copyWith({
    String? id,
    String? name,
    String? location,
    double? lat,
    double? long,
  }) {
    return InstitutionsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'lat': lat,
      'long': long,
    };
  }

  factory InstitutionsModel.fromMap(Map<String, dynamic> map) {
    return InstitutionsModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      long: map['long']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory InstitutionsModel.fromJson(String source) =>
      InstitutionsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InstitutionsModel(id: $id, name: $name, location: $location, lat: $lat, long: $long)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InstitutionsModel &&
        other.id == id &&
        other.name == name &&
        other.location == location &&
        other.lat == lat &&
        other.long == long;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        location.hashCode ^
        lat.hashCode ^
        long.hashCode;
  }

  static List<InstitutionsModel> dummyData() {
    return universities
        .map((e) => InstitutionsModel.fromMap(e))
        .toList();
  }
}
