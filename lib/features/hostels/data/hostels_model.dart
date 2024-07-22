import 'dart:convert';
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:unidwell_finder/core/constatnts/options_list.dart';

class HostelsModel {
  String id;
  String name;
  String location;
  String description;
  List<String> images;
  double lat;
  double lng;
  String managerId;
  String managerName;
  String managerPhone;
  String managerEmail;
  String school;
  String schoolId;
  String status;
  int? createdAt;
  HostelsModel({
    required this.id,
    this.name = '',
    this.location = '',
    this.description = '',
    this.images = const [],
    this.lat = 0,
    this.lng = 0,
    this.managerId = '',
    this.managerName = '',
    this.managerPhone = '',
    this.managerEmail = '',
    this.school = '',
    this.schoolId = '',
    this.status = 'opened',
    this.createdAt,
  });

  HostelsModel copyWith({
    String? id,
    String? name,
    String? location,
    String? description,
    List<String>? images,
    double? lat,
    double? lng,
    String? managerId,
    String? managerName,
    String? managerPhone,
    String? managerEmail,
    String? school,
    String? schoolId,
    String? status,
    ValueGetter<int?>? createdAt,
  }) {
    return HostelsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      description: description ?? this.description,
      images: images ?? this.images,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      managerId: managerId ?? this.managerId,
      managerName: managerName ?? this.managerName,
      managerPhone: managerPhone ?? this.managerPhone,
      managerEmail: managerEmail ?? this.managerEmail,
      school: school ?? this.school,
      schoolId: schoolId ?? this.schoolId,
      status: status ?? this.status,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'description': description,
      'images': images,
      'lat': lat,
      'lng': lng,
      'managerId': managerId,
      'managerName': managerName,
      'managerPhone': managerPhone,
      'managerEmail': managerEmail,
      'school': school,
      'schoolId': schoolId,
      'status': status,
      'createdAt': createdAt,
    };
  }

  factory HostelsModel.fromMap(Map<String, dynamic> map) {
    return HostelsModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      description: map['description'] ?? '',
      images: List<String>.from(map['images']),
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
      managerId: map['managerId'] ?? '',
      managerName: map['managerName'] ?? '',
      managerPhone: map['managerPhone'] ?? '',
      managerEmail: map['managerEmail'] ?? '',
      school: map['school'] ?? '',
      schoolId: map['schoolId'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['createdAt']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory HostelsModel.fromJson(String source) =>
      HostelsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HostelsModel(id: $id, name: $name, location: $location, description: $description, images: $images, lat: $lat, lng: $lng, managerId: $managerId, managerName: $managerName, managerPhone: $managerPhone, managerEmail: $managerEmail, school: $school, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HostelsModel &&
        other.id == id &&
        other.name == name &&
        other.location == location &&
        other.description == description &&
        listEquals(other.images, images) &&
        other.lat == lat &&
        other.lng == lng &&
        other.managerId == managerId &&
        other.managerName == managerName &&
        other.managerPhone == managerPhone &&
        other.managerEmail == managerEmail &&
        other.school == school &&
        other.status == status &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        location.hashCode ^
        description.hashCode ^
        images.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        managerId.hashCode ^
        managerName.hashCode ^
        managerPhone.hashCode ^
        managerEmail.hashCode ^
        school.hashCode ^
        status.hashCode ^
        createdAt.hashCode;
  }

  static List<HostelsModel> dummyHostels() {
    List<String> images = [
      'https://ashanti.co.za/wp-content/uploads/2017/12/Swimming-pool.jpg',
      'https://media.nomadicmatt.com/2023/capetownhostel3.jpeg',
      'https://www.architecturalrecord.com/ext/resources/Issues/2020/03-March/Limpopo-Youth-Hostel-01.jpg?1582837778',
      'https://auca.ac.rw/wp-content/uploads/2022/03/Hostels2.png',
      'https://auca.ac.rw/wp-content/uploads/2019/09/005-G3.jpg',
      'https://blog.getrooms.co/wp-content/uploads/2018/01/IMG_1350-976.jpg',
      'https://www.hostelz.com/pics/imported/listings/thumbnails/54/5523954.jpg',
      'https://d.otcdn.com/imglib/hotelfotos/8/360/pink-hostel-accra-008.jpg',
      'https://c.otcdn.com/imglib/hotelfotos/8/360/pink-hostel-accra-006.jpg',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Ghana_Hostels_Limited_%28UEW%29.jpg/1200px-Ghana_Hostels_Limited_%28UEW%29.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-s/13/f8/85/55/aerial-view-of-hotel.jpg',
      'https://www.accrahotelsnow.com/data/Photos/700x500w/6695/669561/669561453/accra-home-boutique-bb-hostel-and-suite-photo-1.JPEG',
      'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/14/09/36/06/home-boutique-hostel.jpg?w=1200&h=-1&s=1',
      'https://www.accrahotelsnow.com/data/Pics/OriginalPhoto/6338/633887/633887076/pic-the-backpacker-accra-1.JPEG',
      'https://static.readytotrip.com/upload/information_system_24/4/8/4/item_4848443/information_items_4848443.jpg',
      'https://pbs.twimg.com/media/F6AolRiWgAAAchj.jpg',
      'https://pbs.twimg.com/media/E7P7KubXEAcjApy.jpg',
      'https://pbs.twimg.com/media/GC_u0nDXkAAMYMX.jpg',
      'https://i0.wp.com/obuasitoday.com/wp-content/uploads/2023/11/WhatsApp-Image-2023-11-27-at-06.21.55_24ef0c63.jpg?fit=960%2C399&ssl=1',
      'https://tertiary24.com/wp-content/uploads/2023/03/List-of-Hostels-at-KNUST-Obuasi-Campus-With-Their-Prices-2023.jpeg',
      'https://www.uccollegemeghalaya.ac.in/public/facilities/girls_hostel.png',
      'https://www.uccollegemeghalaya.ac.in/public/facilities/boys_hostel.png',
      'https://pbs.twimg.com/media/E7FDn_JWQAAqGTH.jpg:large',
      'https://blog.getrooms.co/wp-content/uploads/2018/01/IMG_1516-96.jpg',
      'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2a/38/d7/14/introducing-our-stunning.jpg?w=700&h=-1&s=1',
      'https://international.ucc.edu.gh/sites/default/files/CIE/Alumni%20Hostel.jpg',
      'https://pbs.twimg.com/media/CqOKR4aWEAA-Q-x.jpg:large',
      'https://kabsolutionssite.wordpress.com/wp-content/uploads/2016/10/sam_5635.jpg?w=816',
      'https://www.ferdashostels.com/img/hostels/nest.jpg',
      'https://images.collegedunia.com/public/college_data/images/campusimage/1427452362unn1.JPG'
          'https://www.ferdashostels.com/img/hostels/sammy-otoo.jpg'
    ];
    List<Map<String, dynamic>> hostels = [
      {
        "id": "1",
        "name": "Pentagon Hostel",
        "location": "University of Ghana, Legon",
        "description":
            "Pentagon Hostel is a spacious and modern accommodation facility located within the University of Ghana, Legon campus. It offers a serene environment conducive for academic activities, with amenities such as a common room, study areas, and Wi-Fi.",
        "images": ["pentagon1.jpg", "pentagon2.jpg"],
        "lat": 5.6508,
        "lng": -0.1870,
        "managerId": "m1",
        "managerName": "John Doe",
        "managerPhone": "0244123456",
        "managerEmail": "john.doe@pentagon.com",
        "status": "Open",
        "createdAt": 1627903200,
      },
      {
        "id": "2",
        "name": "Evandy Hostel",
        "location": "University of Ghana, Legon",
        "description":
            "Evandy Hostel provides comfortable and affordable accommodation for students of the University of Ghana. Located close to academic buildings, it features clean rooms, a cafeteria, and a recreation center.",
        "images": ["evandy1.jpg", "evandy2.jpg"],
        "lat": 5.6550,
        "lng": -0.1873,
        "managerId": "m2",
        "managerName": "Jane Smith",
        "managerPhone": "0244678901",
        "managerEmail": "jane.smith@evandy.com",
        "status": "Open",
        "createdAt": 1628003200,
      },
      {
        "id": "3",
        "name": "Bani Hostel",
        "location":
            "Kwame Nkrumah University of Science and Technology, Kumasi",
        "description":
            "Bani Hostel offers a peaceful and secure living environment for students at KNUST. It includes modern amenities such as air-conditioned rooms, a mini-mart, and 24/7 security services.",
        "images": ["bani1.jpg", "bani2.jpg"],
        "lat": 6.6730,
        "lng": -1.5646,
        "managerId": "m3",
        "managerName": "Michael Adom",
        "managerPhone": "0244789654",
        "managerEmail": "michael.adom@bani.com",
        "status": "Open",
        "createdAt": 1628103200,
      },
      {
        "id": "4",
        "name": "GUSSS Hostel",
        "location":
            "Kwame Nkrumah University of Science and Technology, Kumasi",
        "description":
            "GUSSS Hostel is renowned for its excellent facilities, including spacious rooms, a fitness center, and laundry services. It is strategically located within the KNUST campus to ensure easy access to lectures and other university activities.",
        "images": ["gusss1.jpg", "gusss2.jpg"],
        "lat": 6.6740,
        "lng": -1.5650,
        "managerId": "m4",
        "managerName": "Sarah Ofori",
        "managerPhone": "0244123789",
        "managerEmail": "sarah.ofori@gusss.com",
        "status": "Open",
        "createdAt": 1628203200,
      },
      {
        "id": "5",
        "name": "Continental Hostel",
        "location": "University of Cape Coast, Cape Coast",
        "description":
            "Continental Hostel provides students of UCC with a comfortable living space, equipped with essential amenities such as study rooms, Wi-Fi, and a dining hall. Its proximity to academic blocks makes it a preferred choice for many students.",
        "images": ["continental1.jpg", "continental2.jpg"],
        "lat": 5.1106,
        "lng": -1.2788,
        "managerId": "m5",
        "managerName": "Daniel Mensah",
        "managerPhone": "0244123890",
        "managerEmail": "daniel.mensah@continental.com",
        "status": "Open",
        "createdAt": 1628303200,
      },
      {
        "id": "6",
        "name": "SRC Hostel",
        "location": "University of Cape Coast, Cape Coast",
        "description":
            "SRC Hostel offers a blend of comfort and convenience for students of UCC. It features modern rooms, a recreational area, and 24-hour security. The hostel is known for its vibrant student community.",
        "images": ["src1.jpg", "src2.jpg"],
        "lat": 5.1110,
        "lng": -1.2790,
        "managerId": "m6",
        "managerName": "Linda Appiah",
        "managerPhone": "0244678912",
        "managerEmail": "linda.appiah@src.com",
        "status": "Open",
        "createdAt": 1628403200,
      },
      {
        "id": "7",
        "name": "TF Hostel",
        "location": "University of Education, Winneba",
        "description":
            "TF Hostel is a well-maintained facility providing students of UEW with excellent accommodation. It offers spacious rooms, reliable internet connectivity, and a supportive living environment.",
        "images": ["tf1.jpg", "tf2.jpg"],
        "lat": 5.3515,
        "lng": -0.6234,
        "managerId": "m7",
        "managerName": "Peter Asare",
        "managerPhone": "0244789123",
        "managerEmail": "peter.asare@tf.com",
        "status": "Open",
        "createdAt": 1628503200,
      },
      {
        "id": "8",
        "name": "North Campus Hostel",
        "location": "University of Education, Winneba",
        "description":
            "North Campus Hostel offers a serene environment for students, with facilities such as a study area, a cafeteria, and a mini-market. It is conveniently located near the academic blocks.",
        "images": ["north1.jpg", "north2.jpg"],
        "lat": 5.3530,
        "lng": -0.6240,
        "managerId": "m8",
        "managerName": "Ama Osei",
        "managerPhone": "0244123891",
        "managerEmail": "ama.osei@northcampus.com",
        "status": "Open",
        "createdAt": 1628603200,
      },
      {
        "id": "9",
        "name": "SRC Hostel",
        "location": "University for Development Studies, Tamale",
        "description":
            "SRC Hostel in UDS, Tamale, provides students with a comfortable and secure living space. The hostel features modern rooms, a study area, and a cafeteria, making it a popular choice among students.",
        "images": ["src_uds1.jpg", "src_uds2.jpg"],
        "lat": 9.4000,
        "lng": -0.8393,
        "managerId": "m9",
        "managerName": "Kwame Agyeman",
        "managerPhone": "0244789345",
        "managerEmail": "kwame.agyeman@srcuds.com",
        "status": "Open",
        "createdAt": 1628703200,
      },
      {
        "id": "10",
        "name": "Tamale Hostel",
        "location": "University for Development Studies, Tamale",
        "description":
            "Tamale Hostel offers affordable and convenient accommodation for students of UDS. The hostel is equipped with essential amenities such as a common room, Wi-Fi, and 24-hour security.",
        "images": ["tamale1.jpg", "tamale2.jpg"],
        "lat": 9.4010,
        "lng": -0.8395,
        "managerId": "m10",
        "managerName": "Alice Boakye",
        "managerPhone": "0244678923",
        "managerEmail": "alice.boakye@tamalehostel.com",
        "status": "Open",
        "createdAt": 1628803200,
      },
      {
        "id": "11",
        "name": "Pentagon North Hostel",
        "location": "University of Ghana, Legon",
        "description":
            "Pentagon North Hostel is known for its modern facilities and comfortable living spaces. Located within the University of Ghana campus, it offers easy access to lecture halls and other campus amenities.",
        "images": ["pentagon_north1.jpg", "pentagon_north2.jpg"],
        "lat": 5.6510,
        "lng": -0.1875,
        "managerId": "m11",
        "managerName": "Thomas Kwakye",
        "managerPhone": "0244234567",
        "managerEmail": "thomas.kwakye@pentagon.com",
        "status": "Open",
        "createdAt": 1628903200,
      },
      {
        "id": "12",
        "name": "Africa Union Hall",
        "location":
            "Kwame Nkrumah University of Science and Technology, Kumasi",
        "description":
            "Africa Union Hall, commonly known as Conti, is one of the most vibrant hostels at KNUST. It offers a conducive environment for learning and socializing, with amenities such as a basketball court and a reading room.",
        "images": ["africa_union1.jpg", "africa_union2.jpg"],
        "lat": 6.6745,
        "lng": -1.5655,
        "managerId": "m12",
        "managerName": "Elizabeth Owusu",
        "managerPhone": "0244345678",
        "managerEmail": "elizabeth.owusu@conti.com",
        "status": "Open",
        "createdAt": 1629003200,
      },
      {
        "id": "13",
        "name": "Republic Hall",
        "location":
            "Kwame Nkrumah University of Science and Technology, Kumasi",
        "description":
            "Republic Hall offers a serene and secure environment for students at KNUST. The hostel features well-furnished rooms, a library, and a common room for social activities.",
        "images": ["republic1.jpg", "republic2.jpg"],
        "lat": 6.6750,
        "lng": -1.5660,
        "managerId": "m13",
        "managerName": "George Mensah",
        "managerPhone": "0244456789",
        "managerEmail": "george.mensah@republic.com",
        "status": "Open",
        "createdAt": 1629103200,
      },
      {
        "id": "14",
        "name": "Independence Hall",
        "location":
            "Kwame Nkrumah University of Science and Technology, Kumasi",
        "description":
            "Independence Hall, often referred to as Indece, is a premier hostel offering top-notch facilities. It is known for its spacious rooms, excellent security, and a vibrant student community.",
        "images": ["independence1.jpg", "independence2.jpg"],
        "lat": 6.6755,
        "lng": -1.5665,
        "managerId": "m14",
        "managerName": "Grace Aidoo",
        "managerPhone": "0244567890",
        "managerEmail": "grace.aidoo@indece.com",
        "status": "Open",
        "createdAt": 1629203200,
      },
      {
        "id": "15",
        "name": "Unity Hall",
        "location":
            "Kwame Nkrumah University of Science and Technology, Kumasi",
        "description":
            "Unity Hall, also known as Conti, is one of the largest hostels at KNUST. It provides students with a comfortable living environment, complete with study areas, recreational facilities, and internet access.",
        "images": ["unity1.jpg", "unity2.jpg"],
        "lat": 6.6760,
        "lng": -1.5670,
        "managerId": "m15",
        "managerName": "Francis Nyarko",
        "managerPhone": "0244678902",
        "managerEmail": "francis.nyarko@conti.com",
        "status": "Open",
        "createdAt": 1629303200,
      },
      {
        "id": "16",
        "name": "Valco Trust Hostel",
        "location": "University of Cape Coast, Cape Coast",
        "description":
            "Valco Trust Hostel is a well-known accommodation facility at UCC, offering students a conducive environment for both academic and social activities. The hostel features clean rooms, a study area, and a common room.",
        "images": ["valco1.jpg", "valco2.jpg"],
        "lat": 5.1120,
        "lng": -1.2800,
        "managerId": "m16",
        "managerName": "Josephine Addo",
        "managerPhone": "0244789234",
        "managerEmail": "josephine.addo@valco.com",
        "status": "Open",
        "createdAt": 1629403200,
      },
      {
        "id": "17",
        "name": "Casford Hall",
        "location": "University of Cape Coast, Cape Coast",
        "description":
            "Casford Hall, one of the oldest and most prestigious hostels at UCC, offers students a rich blend of tradition and modernity. The hostel is equipped with essential amenities such as a library, common room, and recreational facilities.",
        "images": ["casford1.jpg", "casford2.jpg"],
        "lat": 5.1125,
        "lng": -1.2805,
        "managerId": "m17",
        "managerName": "Yaw Asante",
        "managerPhone": "0244892345",
        "managerEmail": "yaw.asante@casford.com",
        "status": "Open",
        "createdAt": 1629503200,
      },
      {
        "id": "18",
        "name": "ATL Hall",
        "location": "University of Cape Coast, Cape Coast",
        "description":
            "ATL Hall is a popular choice for students at UCC due to its modern facilities and vibrant student life. The hostel provides spacious rooms, a dining hall, and a common room for social activities.",
        "images": ["atl1.jpg", "atl2.jpg"],
        "lat": 5.1130,
        "lng": -1.2810,
        "managerId": "m18",
        "managerName": "Emmanuel Tetteh",
        "managerPhone": "0244789236",
        "managerEmail": "emmanuel.tetteh@atl.com",
        "status": "Open",
        "createdAt": 1629603200,
      },
      {
        "id": "19",
        "name": "Kwapong Hall",
        "location": "University of Ghana, Legon",
        "description":
            "Kwapong Hall is one of the newer hostels at the University of Ghana, offering state-of-the-art facilities. It provides students with a comfortable and conducive environment for academic and social activities.",
        "images": ["kwapong1.jpg", "kwapong2.jpg"],
        "lat": 5.6515,
        "lng": -0.1880,
        "managerId": "m19",
        "managerName": "Samuel Obeng",
        "managerPhone": "0244892376",
        "managerEmail": "samuel.obeng@kwapong.com",
        "status": "Open",
        "createdAt": 1629703200,
      },
      {
        "id": "20",
        "name": "Hilla Limann Hall",
        "location": "University of Ghana, Legon",
        "description":
            "Hilla Limann Hall is known for its excellent facilities and supportive community. Located on the University of Ghana campus, it offers students a comfortable living environment with amenities such as study rooms and internet access.",
        "images": ["hilla1.jpg", "hilla2.jpg"],
        "lat": 5.6520,
        "lng": -0.1885,
        "managerId": "m20",
        "managerName": "Rebecca Akoto",
        "managerPhone": "0244892389",
        "managerEmail": "rebecca.akoto@hillalimann.com",
        "status": "Open",
        "createdAt": 1629803200,
      },
      {
        "id": "21",
        "name": "Jean Nelson Hall",
        "location": "University of Ghana, Legon",
        "description":
            "Jean Nelson Hall offers a modern and secure living environment for students at the University of Ghana. It features well-furnished rooms, a study area, and a common room for social interactions.",
        "images": ["jean1.jpg", "jean2.jpg"],
        "lat": 5.6525,
        "lng": -0.1890,
        "managerId": "m21",
        "managerName": "Isaac Kusi",
        "managerPhone": "0244892390",
        "managerEmail": "isaac.kusi@jeannelson.com",
        "status": "Open",
        "createdAt": 1629903200,
      },
      {
        "id": "22",
        "name": "Elizabeth Sey Hall",
        "location": "University of Cape Coast, Cape Coast",
        "description":
            "Elizabeth Sey Hall is a premier hostel at UCC, offering students a blend of comfort and convenience. The hostel is equipped with modern facilities including air-conditioned rooms, a dining hall, and a study area.",
        "images": ["sey1.jpg", "sey2.jpg"],
        "lat": 5.1135,
        "lng": -1.2815,
        "managerId": "m22",
        "managerName": "Gloria Asiedu",
        "managerPhone": "0244892391",
        "managerEmail": "gloria.asiedu@sey.com",
        "status": "Open",
        "createdAt": 1630003200,
      },
      {
        "id": "23",
        "name": "Limann Hostel",
        "location": "University of Education, Winneba",
        "description":
            "Limann Hostel provides students of UEW with a conducive living environment, featuring modern rooms, a cafeteria, and a common room. The hostel is located close to the academic blocks, ensuring easy access to lectures.",
        "images": ["limann1.jpg", "limann2.jpg"],
        "lat": 5.3535,
        "lng": -0.6250,
        "managerId": "m23",
        "managerName": "Patricia Mensah",
        "managerPhone": "0244892392",
        "managerEmail": "patricia.mensah@limann.com",
        "status": "Open",
        "createdAt": 1630103200,
      },
      {
        "id": "24",
        "name": "Amamoma Hostel",
        "location": "University of Cape Coast, Cape Coast",
        "description":
            "Amamoma Hostel offers affordable and comfortable accommodation for students at UCC. The hostel features well-furnished rooms, a study area, and a recreation center.",
        "images": ["amamoma1.jpg", "amamoma2.jpg"],
        "lat": 5.1140,
        "lng": -1.2820,
        "managerId": "m24",
        "managerName": "Richard Osei",
        "managerPhone": "0244892393",
        "managerEmail": "richard.osei@amamoma.com",
        "status": "Open",
        "createdAt": 1630203200,
      },
      {
        "id": "25",
        "name": "ATL Annex Hostel",
        "location": "University of Cape Coast, Cape Coast",
        "description":
            "ATL Annex Hostel is a modern accommodation facility at UCC, offering students a comfortable and secure living space. The hostel is equipped with essential amenities such as Wi-Fi, study rooms, and a common room.",
        "images": ["atl_annex1.jpg", "atl_annex2.jpg"],
        "lat": 5.1145,
        "lng": -1.2825,
        "managerId": "m25",
        "managerName": "Dorothy Asamoah",
        "managerPhone": "0244892394",
        "managerEmail": "dorothy.asamoah@atlannex.com",
        "status": "Open",
        "createdAt": 1630303200,
      },
      {
        "id": "26",
        "name": "Vikings Hostel",
        "location": "University of Cape Coast, Cape Coast",
        "description":
            "Vikings Hostel provides students of UCC with a comfortable and secure living environment. The hostel features spacious rooms, a common room, and a study area, making it an ideal choice for students.",
        "images": ["vikings1.jpg", "vikings2.jpg"],
        "lat": 5.1150,
        "lng": -1.2830,
        "managerId": "m26",
        "managerName": "Stephen Asare",
        "managerPhone": "0244892395",
        "managerEmail": "stephen.asare@vikings.com",
        "status": "Open",
        "createdAt": 1630403200,
      },
      {
        "id": "27",
        "name": "Opoku Ware II Hall",
        "location":
            "Kwame Nkrumah University of Science and Technology, Kumasi",
        "description":
            "Opoku Ware II Hall is one of the most sought-after hostels at KNUST, known for its excellent facilities and vibrant student community. The hostel offers spacious rooms, a gym, and a study area.",
        "images": ["opoku1.jpg", "opoku2.jpg"],
        "lat": 6.6765,
        "lng": -1.5675,
        "managerId": "m27",
        "managerName": "Evelyn Osei",
        "managerPhone": "0244892396",
        "managerEmail": "evelyn.osei@opokuware.com",
        "status": "Open",
        "createdAt": 1630503200,
      },
      {
        "id": "28",
        "name": "Unity Hall Annex",
        "location":
            "Kwame Nkrumah University of Science and Technology, Kumasi",
        "description":
            "Unity Hall Annex provides students with a comfortable living environment, featuring modern rooms, a common room, and a study area. It is conveniently located within the KNUST campus.",
        "images": ["unity_annex1.jpg", "unity_annex2.jpg"],
        "lat": 6.6770,
        "lng": -1.5680,
        "managerId": "m28",
        "managerName": "Philip Adu",
        "managerPhone": "0244892397",
        "managerEmail": "philip.adu@unityannex.com",
        "status": "Open",
        "createdAt": 1630603200,
      },
      {
        "id": "29",
        "name": "Limann Hostel Annex",
        "location": "University of Education, Winneba",
        "description":
            "Limann Hostel Annex is a modern accommodation facility at UEW, offering students a comfortable and secure living space. The hostel is equipped with essential amenities such as Wi-Fi, study rooms, and a common room.",
        "images": ["limann_annex1.jpg", "limann_annex2.jpg"],
        "lat": 5.3540,
        "lng": -0.6255,
        "managerId": "m29",
        "managerName": "Joyce Antwi",
        "managerPhone": "0244892398",
        "managerEmail": "joyce.antwi@limannannex.com",
        "status": "Open",
        "createdAt": 1630703200,
      },
      {
        "id": "30",
        "name": "Commonwealth Hall",
        "location": "University of Ghana, Legon",
        "description":
            "Commonwealth Hall, also known as Vandal City, is a vibrant and historically significant hostel at the University of Ghana. It offers students a rich blend of tradition, modernity, and a strong sense of community.",
        "images": ["commonwealth1.jpg", "commonwealth2.jpg"],
        "lat": 5.6525,
        "lng": -0.1895,
        "managerId": "m30",
        "managerName": "Kwabena Adu",
        "managerPhone": "0244892399",
        "managerEmail": "kwabena.adu@commonwealth.com",
        "status": "Open",
        "createdAt": 1630803200,
      }
    ];
    List<HostelsModel> hostelsList = [];
    var faker = Faker();
    for (int i = 0; i < images.length; i++) {
      var hostel = HostelsModel(
          id: '',
          name: hostels[i]['name'],
          location: hostels[i]['location'],
          description: hostels[i]['description'],
          images: [images[i]],
          lat: hostels[i]['lat'],
          lng: hostels[i]['lng'],
          managerId: '',
          managerName: '',
          managerPhone: '',
          managerEmail: '',
          createdAt: DateTime.now().millisecondsSinceEpoch,
          school: faker.randomGenerator.element(
              universities.map((school) => school['name'].toString()).toList()),
          status: faker.randomGenerator.element(['opened', 'full']));
      hostelsList.add(hostel);
    }
    return hostelsList;
  }
}
