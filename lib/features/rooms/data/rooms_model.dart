import 'dart:convert';
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:unidwell_finder/core/constatnts/options_list.dart';

class RoomsModel {
  String id;
  String title;
  String description;
  String hostelId;
  String hostelName;
  String managerId;
  String managerName;
  String managerPhone;
  String managerEmail;
  String status;
  double price;
  double additionalCost;
  int capacity;
  List<String> images;
  String bathroomType;
  String kitchingType;
  String bedType;
  List<String> features;
  List<String> rules;
  String roomType;
  int availableSpace;
  String institution;
  int? createdAt;
  RoomsModel({
    required this.id,
     this.title='',
     this.description = '',
     this.hostelId = '',
     this.hostelName = '',
     this.managerId = '',
     this.managerName = '',
     this.managerPhone = '',
     this.managerEmail = '',
    this.status = 'available',
     this.price = 0,
     this.additionalCost = 0,
     this.capacity = 0,
     this.images = const [],
     this.bathroomType = '',
     this.kitchingType = '',
     this.bedType = '',
    this.features = const [],
    this.rules = const [],
     this.roomType = '',
     this.availableSpace = 0,
     this.institution = '',
    this.createdAt,
  });

  RoomsModel copyWith({
    String? id,
    String? title,
    String? description,
    String? hostelId,
    String? hostelName,
    String? managerId,
    String? managerName,
    String? managerPhone,
    String? managerEmail,
    String? status,
    double? price,
    double? additionalCost,
    int? capacity,
    List<String>? images,
    String? bathroomType,
    String? kitchingType,
    String? bedType,
    List<String>? features,
    List<String>? rules,
    String? roomType,
    int? availableSpace,
    String? institution,
    ValueGetter<int?>? createdAt,
  }) {
    return RoomsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      hostelId: hostelId ?? this.hostelId,
      hostelName: hostelName ?? this.hostelName,
      managerId: managerId ?? this.managerId,
      managerName: managerName ?? this.managerName,
      managerPhone: managerPhone ?? this.managerPhone,
      managerEmail: managerEmail ?? this.managerEmail,
      status: status ?? this.status,
      price: price ?? this.price,
      additionalCost: additionalCost ?? this.additionalCost,
      capacity: capacity ?? this.capacity,
      images: images ?? this.images,
      bathroomType: bathroomType ?? this.bathroomType,
      kitchingType: kitchingType ?? this.kitchingType,
      bedType: bedType ?? this.bedType,
      features: features ?? this.features,
      rules: rules ?? this.rules,
      roomType: roomType ?? this.roomType,
      availableSpace: availableSpace ?? this.availableSpace,
      institution: institution ?? this.institution,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'hostelId': hostelId,
      'hostelName': hostelName,
      'managerId': managerId,
      'managerName': managerName,
      'managerPhone': managerPhone,
      'managerEmail': managerEmail,
      'status': status,
      'price': price,
      'additionalCost': additionalCost,
      'capacity': capacity,
      'images': images,
      'bathroomType': bathroomType,
      'kitchingType': kitchingType,
      'bedType': bedType,
      'features': features,
      'rules': rules,
      'roomType': roomType,
      'availableSpace': availableSpace,
      'institution': institution,
      'createdAt': createdAt,
    };
  }

  factory RoomsModel.fromMap(Map<String, dynamic> map) {
    return RoomsModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      hostelId: map['hostelId'] ?? '',
      hostelName: map['hostelName'] ?? '',
      managerId: map['managerId'] ?? '',
      managerName: map['managerName'] ?? '',
      managerPhone: map['managerPhone'] ?? '',
      managerEmail: map['managerEmail'] ?? '',
      status: map['status'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      additionalCost: map['additionalCost']?.toDouble() ?? 0.0,
      capacity: map['capacity']?.toInt() ?? 0,
      images: List<String>.from(map['images']),
      bathroomType: map['bathroomType'] ?? '',
      kitchingType: map['kitchingType'] ?? '',
      bedType: map['bedType'] ?? '',
      features: List<String>.from(map['features']),
      rules: List<String>.from(map['rules']),
      roomType: map['roomType'] ?? '',
      availableSpace: map['availableSpace']?.toInt() ?? 0,
      institution: map['institution'] ?? '',
      createdAt: map['createdAt']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomsModel.fromJson(String source) =>
      RoomsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomsModel(id: $id, title: $title, description: $description, hostelId: $hostelId, hostelName: $hostelName, managerId: $managerId, managerName: $managerName, managerPhone: $managerPhone, managerEmail: $managerEmail, status: $status, price: $price, additionalCost: $additionalCost, capacity: $capacity, images: $images, bathroomType: $bathroomType, kitchingType: $kitchingType, bedType: $bedType, features: $features, rules: $rules, roomType: $roomType, availableSpace: $availableSpace, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomsModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.hostelId == hostelId &&
        other.hostelName == hostelName &&
        other.managerId == managerId &&
        other.managerName == managerName &&
        other.managerPhone == managerPhone &&
        other.managerEmail == managerEmail &&
        other.status == status &&
        other.price == price &&
        other.additionalCost == additionalCost &&
        other.capacity == capacity &&
        listEquals(other.images, images) &&
        other.bathroomType == bathroomType &&
        other.kitchingType == kitchingType &&
        other.bedType == bedType &&
        listEquals(other.features, features) &&
        listEquals(other.rules, rules) &&
        other.roomType == roomType &&
        other.availableSpace == availableSpace &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        hostelId.hashCode ^
        hostelName.hashCode ^
        managerId.hashCode ^
        managerName.hashCode ^
        managerPhone.hashCode ^
        managerEmail.hashCode ^
        status.hashCode ^
        price.hashCode ^
        additionalCost.hashCode ^
        capacity.hashCode ^
        images.hashCode ^
        bathroomType.hashCode ^
        kitchingType.hashCode ^
        bedType.hashCode ^
        features.hashCode ^
        rules.hashCode ^
        roomType.hashCode ^
        availableSpace.hashCode ^
        createdAt.hashCode;
  }

  static List<RoomsModel> getDummy() {
    List<RoomsModel> rooms = [];
    List<String> images = [
      'https://pix10.agoda.net/hotelImages/159325/0/0cc66f9594c8eae04bfab20f10417225.jpeg?s=414x232&ar=16x9',
      'https://theafricanvibrations.com/wp-content/uploads/2023/04/450A7995-1-scaled.jpg',
      'https://stay-africa-hostel.capetown-hotels-za.com/data/Pics/OriginalPhoto/7733/773376/773376052/stay-africa-hostel-cape-town-pic-6.JPEG',
      'https://elitehostels.co.ke/wp-content/uploads/2015/10/room1.jpg',
      'https://cf.bstatic.com/xdata/images/hotel/max1024x768/289272826.jpg?k=b60bd5391badf988ca7e3da15ffefb29d242939d7e9bef70e40aadb13ad7d740&o=&hp=1',
      'https://hostel-kw-gangnam.seoulhotelspage.com/data/Imgs/OriginalPhoto/6842/684220/684220296/img-hostel-kw-gangnam-seoul-17.JPEG',
      'https://www.hostelz.com/pics/imported/listings/thumbnails/98/5287398.jpg',
      'https://media.gettyimages.com/id/1215927063/photo/studying-is-a-cruise-when-you-love-your-majors.jpg?s=612x612&w=gi&k=20&c=hmvoppArHXK7JX0FoXPAPc4QgiAesvoPQOdRP6Jgv0o=',
      'https://media.istockphoto.com/id/1215927117/photo/shes-no-crammer-she-prefers-to-comprehend.jpg?s=612x612&w=0&k=20&c=vD9SxoWLwUTFjSYw80QPf0cTgwwtvo9JSFvGN6u9AZc=',
      'https://hostel-mama-africa-2-gamboa.hoteis-noreste-de-brasil.com/data/Images/OriginalPhoto/11159/1115945/1115945295/image-gamboa-bahia-hostel-mama-africa-2-gamboa-37.JPEG'
    ];
    List<Map<String, dynamic>> hostels = [
      {
        'title': '3 in a room hostel close to AAMUSTED',
        'desc':
            'Room is very spacious to accommodate your items. Very close to AAMUSTED with just a 4-minute walk.',
        'price': 'GHS 1000'
      },
      {
        'title': 'Single room hostel near UEW',
        'desc':
            'A quiet and serene environment perfect for studying. Just a 10-minute walk to UEW.',
        'price': 'GHS 1500'
      },
      {
        'title': 'Double room hostel at North Campus',
        'desc':
            'Spacious rooms with good ventilation. Located at North Campus with easy access to transport.',
        'price': 'GHS 1200'
      },
      {
        'title': '4 in a room hostel near Amakom',
        'desc':
            'Affordable and spacious. Situated at Amakom, a vibrant area with many amenities.',
        'price': 'GHS 800'
      },
      {
        'title': '2 in a room hostel near KNUST',
        'desc': 'Modern facilities with study areas. A 5-minute walk to KNUST.',
        'price': 'GHS 1400'
      },
      {
        'title': 'Single room hostel at Ayeduase',
        'desc':
            'Newly built with modern amenities. Located in Ayeduase, a peaceful neighborhood.',
        'price': 'GHS 1700'
      },
      {
        'title': '3 in a room hostel close to Kumasi Poly',
        'desc':
            'Spacious and well-furnished rooms. A short 3-minute walk to Kumasi Polytechnic.',
        'price': 'GHS 1100'
      },
      {
        'title': 'Double room hostel at Asokwa',
        'desc':
            'Comfortable living space with good security. Close to Asokwa Market.',
        'price': 'GHS 1300'
      },
      {
        'title': 'Single room hostel at Patasi',
        'desc':
            'Quiet and conducive for studying. Located in Patasi, with easy access to transport.',
        'price': 'GHS 1600'
      },
      {
        'title': '2 in a room hostel near Tech Junction',
        'desc':
            'Well-maintained rooms with free Wi-Fi. Just a 7-minute walk to Tech Junction.',
        'price': 'GHS 1450'
      },
    ];
    List<Map<String, String>> popularHostels = [
      {'hostel': 'TF Hostel', 'institution': 'KNUST'},
      {'hostel': 'Green Hostel', 'institution': 'AAMUSTED'},
      {'hostel': 'Evandy Hostel', 'institution': 'UG-Legon'},
      {'hostel': 'Nyansapo Hostel', 'institution': 'UCC'},
      {'hostel': 'Superannuation Hostel', 'institution': 'UEW'},
      {'hostel': 'Dansoman Hostel', 'institution': 'ATU'},
      {'hostel': 'SRC Hostel', 'institution': 'UPSA'},
      {'hostel': 'Adom Bi Hostel', 'institution': 'UHAS'},
      {'hostel': 'Queens Hall', 'institution': 'KTU'},
      {'hostel': 'Sikaman Hostel', 'institution': 'GIMPA'},
      {'hostel': 'Bishop Charles Hostel', 'institution': 'Ashesi University'},
    ];

    var faker = Faker();
    for (var i = 0; i < hostels.length; i++) {
      var capacity = faker.randomGenerator.integer(4);
      featuresList.shuffle();
      var features = featuresList.sublist(0, faker.randomGenerator.integer(5));
      images.shuffle();
      var room = RoomsModel(
          id: '',
          title: hostels[i]['title'],
          description: hostels[i]['desc'],
          hostelId: faker.guid.guid(),
          hostelName: popularHostels[i]['hostel']!,
          managerId: faker.guid.guid(),
          managerName: faker.person.name(),
          managerPhone: faker.phoneNumber.us(),
          managerEmail: faker.internet.email(),
          price: double.parse(hostels[i]['price'].split(' ')[1]),
          additionalCost: faker.randomGenerator.decimal(),
          capacity: capacity,
          images: images.sublist(0, faker.randomGenerator.integer(4)),
          status: 'available',
          rules: [
            'No smoking',
            'No pets',
            'No loud music',
            'No parties',
          ],
          bathroomType: faker.randomGenerator.element(bathroomTypeList),
          kitchingType: faker.randomGenerator.element(kitchingTypeList),
          bedType: faker.randomGenerator.element(bedTypeList),
          roomType: faker.randomGenerator.element(roomTypeList),
          availableSpace: capacity,
          features: features,
          institution: popularHostels[i]['institution']!);
      rooms.add(room);
    }
    return rooms;
  }
}
