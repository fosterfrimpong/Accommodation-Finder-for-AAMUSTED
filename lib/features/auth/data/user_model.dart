import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter/widgets.dart';
import 'package:unidwell_finder/core/constatnts/options_list.dart';

class UserModel {
  String id;
  String name;
  String email;
  String phone;
  String gender;
  String role;
  String status;
  String? image;
  String? password;
  String? school;
  int? createdAt;
  UserModel({
    this.id = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.gender = '',
    this.role = 'student',
    this.status = 'active',
    this.image,
    this.password,
    this.school,
    this.createdAt,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? gender,
    String? role,
    String? status,
    ValueGetter<String?>? image,
    ValueGetter<String?>? password,
    ValueGetter<String?>? school,
    ValueGetter<int?>? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      role: role ?? this.role,
      status: status ?? this.status,
      image: image != null ? image() : this.image,
      password: password != null ? password() : this.password,
      school: school != null ? school() : this.school,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'gender': gender,
      'role': role,
      'status': status,
      'image': image,
      'school': school,
      'createdAt': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? '',
      role: map['role'] ?? '',
      status: map['status'] ?? '',
      image: map['image'],
      school: map['school'],
      createdAt: map['createdAt']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phone: $phone, gender: $gender, role: $role, status: $status, image: $image, password: $password, school: $school, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.gender == gender &&
        other.role == role &&
        other.status == status &&
        other.image == image &&
        other.password == password &&
        other.school == school &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        gender.hashCode ^
        role.hashCode ^
        status.hashCode ^
        image.hashCode ^
        password.hashCode ^
        school.hashCode ^
        createdAt.hashCode;
  }

  static List<UserModel> dummyData() {
    final faker = Faker();
    List<UserModel> users = [];
    for (var i = 0; i < 10; i++) {
      var role = faker.randomGenerator.element(['student', 'manager']);
      var user = UserModel(
        id: faker.guid.guid(),
        name: faker.person.name(),
        email: faker.internet.email(),
        phone: faker.phoneNumber.us(),
        gender: faker.randomGenerator.element(['Male', 'Female']),
        role: role,
        image: faker.image.image(keywords: ['people']),
        school: role == 'student'
            ? faker.randomGenerator.element(universities.map((e) => e['name'].toString()).toList())
            : null,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      users.add(user);
    }
    return users;
  }
}
