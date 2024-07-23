import 'dart:convert';
import 'package:flutter/foundation.dart';


class BookingModel {
  String? id;
  String? managerId;
  String? studentId;
  List<String> partyIds;
  String? studentName;
  String? managerName;
  String? studentEmail;
  String? managerEmail;
  String? studentPhone;
  String? managerPhone;
  String? status;
  String? startDate;
  String? endDate;
  bool managerSigned;
  bool studentSigned;
  String? hostelId;
  String? hostelName;
  String? roomId;
  String? roomName;
  String? roomDescription;
  String? terms;
  double? roomCost;
  double? totalCost;
  double? additionalCost;
  String? paymentMethod;
  String? paymentStatus;
  String? paymentId;
  int? paymentDate;
  double? hostelLatitude;
  double? hostelLongitude;
  String? hostelAddress;
  List<String> roomImages;
  int? createdAt;
  BookingModel({
    this.id,
    this.managerId,
    this.studentId,
     this.partyIds =const <String>[],
    this.studentName,
    this.managerName,
    this.studentEmail,
    this.managerEmail,
    this.studentPhone,
    this.managerPhone,
    this.status,
    this.startDate,
    this.endDate,
    this.managerSigned=false,
    this.studentSigned=false,
    this.hostelId,
    this.hostelName,
    this.roomId,
    this.roomName,
    this.roomDescription,
    this.terms,
    this.roomCost,
    this.totalCost,
    this.additionalCost,
    this.paymentMethod,
    this.paymentStatus,
    this.paymentId,
    this.paymentDate,
    this.hostelLatitude,
    this.hostelLongitude,
    this.hostelAddress,
     this.roomImages =const <String>[],
    this.createdAt,
  });

  BookingModel copyWith({
    ValueGetter<String?>? id,
    ValueGetter<String?>? managerId,
    ValueGetter<String?>? studentId,
    List<String>? partyIds,
    ValueGetter<String?>? studentName,
    ValueGetter<String?>? managerName,
    ValueGetter<String?>? studentEmail,
    ValueGetter<String?>? managerEmail,
    ValueGetter<String?>? studentPhone,
    ValueGetter<String?>? managerPhone,
    ValueGetter<String?>? status,
    ValueGetter<String?>? startDate,
    ValueGetter<String?>? endDate,
    bool? managerSigned,
    bool? studentSigned,
    ValueGetter<String?>? hostelId,
    ValueGetter<String?>? hostelName,
    ValueGetter<String?>? roomId,
    ValueGetter<String?>? roomName,
    ValueGetter<String?>? roomDescription,
    ValueGetter<String?>? terms,
    ValueGetter<double?>? roomCost,
    ValueGetter<double?>? totalCost,
    ValueGetter<double?>? additionalCost,
    ValueGetter<String?>? paymentMethod,
    ValueGetter<String?>? paymentStatus,
    ValueGetter<String?>? paymentId,
    ValueGetter<int?>? paymentDate,
    ValueGetter<double?>? hostelLatitude,
    ValueGetter<double?>? hostelLongitude,
    ValueGetter<String?>? hostelAddress,
    List<String>? roomImages,
    ValueGetter<int?>? createdAt,
  }) {
    return BookingModel(
      id: id != null ? id() : this.id,
      managerId: managerId != null ? managerId() : this.managerId,
      studentId: studentId != null ? studentId() : this.studentId,
      partyIds: partyIds ?? this.partyIds,
      studentName: studentName != null ? studentName() : this.studentName,
      managerName: managerName != null ? managerName() : this.managerName,
      studentEmail: studentEmail != null ? studentEmail() : this.studentEmail,
      managerEmail: managerEmail != null ? managerEmail() : this.managerEmail,
      studentPhone: studentPhone != null ? studentPhone() : this.studentPhone,
      managerPhone: managerPhone != null ? managerPhone() : this.managerPhone,
      status: status != null ? status() : this.status,
      startDate: startDate != null ? startDate() : this.startDate,
      endDate: endDate != null ? endDate() : this.endDate,
      managerSigned: managerSigned ?? this.managerSigned,
      studentSigned: studentSigned ?? this.studentSigned,
      hostelId: hostelId != null ? hostelId() : this.hostelId,
      hostelName: hostelName != null ? hostelName() : this.hostelName,
      roomId: roomId != null ? roomId() : this.roomId,
      roomName: roomName != null ? roomName() : this.roomName,
      roomDescription: roomDescription != null ? roomDescription() : this.roomDescription,
      terms: terms != null ? terms() : this.terms,
      roomCost: roomCost != null ? roomCost() : this.roomCost,
      totalCost: totalCost != null ? totalCost() : this.totalCost,
      additionalCost: additionalCost != null ? additionalCost() : this.additionalCost,
      paymentMethod: paymentMethod != null ? paymentMethod() : this.paymentMethod,
      paymentStatus: paymentStatus != null ? paymentStatus() : this.paymentStatus,
      paymentId: paymentId != null ? paymentId() : this.paymentId,
      paymentDate: paymentDate != null ? paymentDate() : this.paymentDate,
      hostelLatitude: hostelLatitude != null ? hostelLatitude() : this.hostelLatitude,
      hostelLongitude: hostelLongitude != null ? hostelLongitude() : this.hostelLongitude,
      hostelAddress: hostelAddress != null ? hostelAddress() : this.hostelAddress,
      roomImages: roomImages ?? this.roomImages,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'managerId': managerId,
      'studentId': studentId,
      'partyIds': partyIds,
      'studentName': studentName,
      'managerName': managerName,
      'studentEmail': studentEmail,
      'managerEmail': managerEmail,
      'studentPhone': studentPhone,
      'managerPhone': managerPhone,
      'status': status,
      'startDate': startDate,
      'endDate': endDate,
      'managerSigned': managerSigned,
      'studentSigned': studentSigned,
      'hostelId': hostelId,
      'hostelName': hostelName,
      'roomId': roomId,
      'roomName': roomName,
      'roomDescription': roomDescription,
      'terms': terms,
      'roomCost': roomCost,
      'totalCost': totalCost,
      'additionalCost': additionalCost,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'paymentId': paymentId,
      'paymentDate': paymentDate,
      'hostelLatitude': hostelLatitude,
      'hostelLongitude': hostelLongitude,
      'hostelAddress': hostelAddress,
      'roomImages': roomImages,
      'createdAt': createdAt,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'],
      managerId: map['managerId'],
      studentId: map['studentId'],
      partyIds: List<String>.from(map['partyIds']),
      studentName: map['studentName'],
      managerName: map['managerName'],
      studentEmail: map['studentEmail'],
      managerEmail: map['managerEmail'],
      studentPhone: map['studentPhone'],
      managerPhone: map['managerPhone'],
      status: map['status'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      managerSigned: map['managerSigned'] ?? false,
      studentSigned: map['studentSigned'] ?? false,
      hostelId: map['hostelId'],
      hostelName: map['hostelName'],
      roomId: map['roomId'],
      roomName: map['roomName'],
      roomDescription: map['roomDescription'],
      terms: map['terms'],
      roomCost: map['roomCost']?.toDouble(),
      totalCost: map['totalCost']?.toDouble(),
      additionalCost: map['additionalCost']?.toDouble(),
      paymentMethod: map['paymentMethod'],
      paymentStatus: map['paymentStatus'],
      paymentId: map['paymentId'],
      paymentDate: map['paymentDate']?.toInt(),
      hostelLatitude: map['hostelLatitude']?.toDouble(),
      hostelLongitude: map['hostelLongitude']?.toDouble(),
      hostelAddress: map['hostelAddress'],
      roomImages: List<String>.from(map['roomImages']),
      createdAt: map['createdAt']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingModel.fromJson(String source) =>
      BookingModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookingModel(id: $id, managerId: $managerId, studentId: $studentId, partyIds: $partyIds, studentName: $studentName, managerName: $managerName, studentEmail: $studentEmail, managerEmail: $managerEmail, studentPhone: $studentPhone, managerPhone: $managerPhone, status: $status, startDate: $startDate, endDate: $endDate, managerSigned: $managerSigned, studentSigned: $studentSigned, hostelId: $hostelId, hostelName: $hostelName, roomId: $roomId, roomName: $roomName, roomDescription: $roomDescription, terms: $terms, roomCost: $roomCost, totalCost: $totalCost, additionalCost: $additionalCost, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, paymentId: $paymentId, paymentDate: $paymentDate, hostelLatitude: $hostelLatitude, hostelLongitude: $hostelLongitude, hostelAddress: $hostelAddress, roomImages: $roomImages, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BookingModel &&
      other.id == id &&
      other.managerId == managerId &&
      other.studentId == studentId &&
      listEquals(other.partyIds, partyIds) &&
      other.studentName == studentName &&
      other.managerName == managerName &&
      other.studentEmail == studentEmail &&
      other.managerEmail == managerEmail &&
      other.studentPhone == studentPhone &&
      other.managerPhone == managerPhone &&
      other.status == status &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.managerSigned == managerSigned &&
      other.studentSigned == studentSigned &&
      other.hostelId == hostelId &&
      other.hostelName == hostelName &&
      other.roomId == roomId &&
      other.roomName == roomName &&
      other.roomDescription == roomDescription &&
      other.terms == terms &&
      other.roomCost == roomCost &&
      other.totalCost == totalCost &&
      other.additionalCost == additionalCost &&
      other.paymentMethod == paymentMethod &&
      other.paymentStatus == paymentStatus &&
      other.paymentId == paymentId &&
      other.paymentDate == paymentDate &&
      other.hostelLatitude == hostelLatitude &&
      other.hostelLongitude == hostelLongitude &&
      other.hostelAddress == hostelAddress &&
      listEquals(other.roomImages, roomImages) &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      managerId.hashCode ^
      studentId.hashCode ^
      partyIds.hashCode ^
      studentName.hashCode ^
      managerName.hashCode ^
      studentEmail.hashCode ^
      managerEmail.hashCode ^
      studentPhone.hashCode ^
      managerPhone.hashCode ^
      status.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      managerSigned.hashCode ^
      studentSigned.hashCode ^
      hostelId.hashCode ^
      hostelName.hashCode ^
      roomId.hashCode ^
      roomName.hashCode ^
      roomDescription.hashCode ^
      terms.hashCode ^
      roomCost.hashCode ^
      totalCost.hashCode ^
      additionalCost.hashCode ^
      paymentMethod.hashCode ^
      paymentStatus.hashCode ^
      paymentId.hashCode ^
      paymentDate.hashCode ^
      hostelLatitude.hashCode ^
      hostelLongitude.hashCode ^
      hostelAddress.hashCode ^
      roomImages.hashCode ^
      createdAt.hashCode;
  }
}
