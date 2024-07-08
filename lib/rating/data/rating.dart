import 'dart:convert';
import 'dart:math';

import 'package:faker/faker.dart';

class RatingModel {
  String id;
  String studentId;
  String studentName;
  String studentImage;
  String roomId;
  String message;
  double rating;
  int createdAt;
  RatingModel({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.studentImage,
    required this.roomId,
    required this.message,
    required this.rating,
    required this.createdAt,
  });

  RatingModel copyWith({
    String? id,
    String? studentId,
    String? studentName,
    String? studentImage,
    String? roomId,
    String? message,
    double? rating,
    int? createdAt,
  }) {
    return RatingModel(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      studentImage: studentImage ?? this.studentImage,
      roomId: roomId ?? this.roomId,
      message: message ?? this.message,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentId': studentId,
      'studentName': studentName,
      'studentImage': studentImage,
      'roomId': roomId,
      'message': message,
      'rating': rating,
      'createdAt': createdAt,
    };
  }

  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      id: map['id'] ?? '',
      studentId: map['studentId'] ?? '',
      studentName: map['studentName'] ?? '',
      studentImage: map['studentImage'] ?? '',
      roomId: map['roomId'] ?? '',
      message: map['message'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      createdAt: map['createdAt']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RatingModel.fromJson(String source) =>
      RatingModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RatingModel(id: $id, studentId: $studentId, studentName: $studentName, studentImage: $studentImage, roomId: $roomId, message: $message, rating: $rating, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RatingModel &&
        other.id == id &&
        other.studentId == studentId &&
        other.studentName == studentName &&
        other.studentImage == studentImage &&
        other.roomId == roomId &&
        other.message == message &&
        other.rating == rating &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        studentId.hashCode ^
        studentName.hashCode ^
        studentImage.hashCode ^
        roomId.hashCode ^
        message.hashCode ^
        rating.hashCode ^
        createdAt.hashCode;
  }

  static List<RatingModel> dummyRatings(String roomId) {
    var faker = Faker();
    return List.generate(
      10,
      (index) => RatingModel(
        id: faker.guid.guid(),
        studentId: faker.guid.guid(),
        studentName: faker.person.name(),
        studentImage: faker.image.image(),
        roomId: roomId,
        message: faker.lorem.sentence(),
        rating: generateRandomRating(),
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }
  static double generateRandomRating() {
    Random random = Random();
    // Generates a random double between 1.0 and 5.0, inclusive
    double rating = 1 + random.nextDouble() * 4;
    return double.parse(rating.toStringAsFixed(1)); // Rounds to 1 decimal place
  }
}
