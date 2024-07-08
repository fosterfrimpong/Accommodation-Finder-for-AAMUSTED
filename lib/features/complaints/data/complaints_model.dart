import 'dart:convert';
import 'package:flutter/foundation.dart';


class ComplaintsModel {
  String id;
  String title;
  String description;
  String status;
  String date;
  String studentId;
  String hostelId;
  String roomId;
  String hostelName;
  String managerId;
  String managerName;
  List<String> images;
  int? createdAt;
  ComplaintsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.date,
    required this.studentId,
    required this.hostelId,
    required this.roomId,
    required this.hostelName,
    required this.managerId,
    required this.managerName,
     this.images = const [],
    this.createdAt,
  });

  ComplaintsModel copyWith({
    String? id,
    String? title,
    String? description,
    String? status,
    String? date,
    String? studentId,
    String? hostelId,
    String? roomId,
    String? hostelName,
    String? managerId,
    String? managerName,
    List<String>? images,
    ValueGetter<int?>? createdAt,
  }) {
    return ComplaintsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      date: date ?? this.date,
      studentId: studentId ?? this.studentId,
      hostelId: hostelId ?? this.hostelId,
      roomId: roomId ?? this.roomId,
      hostelName: hostelName ?? this.hostelName,
      managerId: managerId ?? this.managerId,
      managerName: managerName ?? this.managerName,
      images: images ?? this.images,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'date': date,
      'studentId': studentId,
      'hostelId': hostelId,
      'roomId': roomId,
      'hostelName': hostelName,
      'managerId': managerId,
      'managerName': managerName,
      'images': images,
      'createdAt': createdAt,
    };
  }

  factory ComplaintsModel.fromMap(Map<String, dynamic> map) {
    return ComplaintsModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      status: map['status'] ?? '',
      date: map['date'] ?? '',
      studentId: map['studentId'] ?? '',
      hostelId: map['hostelId'] ?? '',
      roomId: map['roomId'] ?? '',
      hostelName: map['hostelName'] ?? '',
      managerId: map['managerId'] ?? '',
      managerName: map['managerName'] ?? '',
      images: List<String>.from(map['images']),
      createdAt: map['createdAt']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ComplaintsModel.fromJson(String source) => ComplaintsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ComplaintsModel(id: $id, title: $title, description: $description, status: $status, date: $date, studentId: $studentId, hostelId: $hostelId, roomId: $roomId, hostelName: $hostelName, managerId: $managerId, managerName: $managerName, images: $images, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ComplaintsModel &&
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.status == status &&
      other.date == date &&
      other.studentId == studentId &&
      other.hostelId == hostelId &&
      other.roomId == roomId &&
      other.hostelName == hostelName &&
      other.managerId == managerId &&
      other.managerName == managerName &&
      listEquals(other.images, images) &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      status.hashCode ^
      date.hashCode ^
      studentId.hashCode ^
      hostelId.hashCode ^
      roomId.hashCode ^
      hostelName.hashCode ^
      managerId.hashCode ^
      managerName.hashCode ^
      images.hashCode ^
      createdAt.hashCode;
  }
}
