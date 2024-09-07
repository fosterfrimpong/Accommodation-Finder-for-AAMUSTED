import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/assets.dart';
import '../../../utils/styles.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  List<Map<String, String>> data = [
    {
      'image': Assets.imagesSlide1,
      'title': 'Create an Account',
      'description':
          'Create an account with us. You can create an account as a student or a landlord or a hostel manager. You can also create an account for someone else. You will be able to manage your account and view your profile. You can also update your profile at any time.'
    },
    {
      'image': Assets.imagesSlide2,
      'title': 'Find Available Room',
      'description':
          'Find available rooms in your area. You can search for rooms by location, price, and type. You can also search for rooms by the number of rooms,  and the number of people. You can also search for rooms by the type of room, the type of bed, and the type of bathroom.'
    },
    {
      'image': Assets.imagesSlide3,
      'title': 'Book a Room',
      'description':
          'Book a room with us. You can book a room for yourself or for someone else. You can book a room for a short period or for a long period. You can also book a room for a group of people. You can also book a room for a family.  '
    },
  ];

  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    return CarouselSlider(
      options: CarouselOptions(
          height: styles.height * 0.5,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal),
      items: data.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: styles.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(i['image']!), fit: BoxFit.cover),
                  color: Colors.amber),
              child: Container(
                  width: styles.width,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: styles.height * 0.5,
                  color: Colors.black.withOpacity(0.1),
                  child: SizedBox(
                    width: styles.isMobile
                        ? styles.width * 0.8
                        : styles.width * 0.6,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          i['title']!,
                          style: styles.title(
                              color: Colors.white,
                              mobile: 45,
                              desktop: 60,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          i['description']!,
                          style: styles.body(
                              color: Colors.white, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )),
            );
          },
        );
      }).toList(),
    );
  }
}
