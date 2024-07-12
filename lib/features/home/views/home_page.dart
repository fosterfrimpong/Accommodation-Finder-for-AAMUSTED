import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/features/auth/services/registration_services.dart';
import 'package:unidwell_finder/features/hostels/data/hostels_model.dart';
import 'package:unidwell_finder/features/hostels/services/hostel_services.dart';
import 'package:unidwell_finder/features/rooms/services/rooms_services.dart';
import 'package:unidwell_finder/rating/data/rating.dart';
import '../../../core/views/footer_page.dart';
import '../../../rating/services/rating_services.dart';
import '../../rooms/data/rooms_model.dart';
import '../pages/landing_page.dart';
import '../pages/rooms_listening.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    var futureProvider = ref.watch(this.futureProvider);
    return futureProvider.when(data: (data) {
      return const SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    LandingPage(),
                    SizedBox(height: 20),
                    RoomsListPage(),
                    SizedBox(height: 20),
                    FooterPage(),
                  ],
                ),
              ],
            ),
          ));
    }, error: (error, stack) {
      return const Center(child: Text('Error'));
    }, loading: () {
      return const Center(child: CircularProgressIndicator());
    });
  }

  final futureProvider = FutureProvider.autoDispose<void>((ref) async {
    // var data = RoomsModel.getDummy();
    // var data = await RoomsServices.getRooms();
    // for (var value in data) {
    //   var ratings = RatingModel.dummyRatings(value.id);
    //   for (var rating in ratings) {
    //     rating.roomId = value.id;
    //     rating.id = RatingServices.getId();
    //     rating.createdAt = DateTime.now().millisecondsSinceEpoch;
    //     await RatingServices.addRating(rating);
    //   }
    // }

    // var rooms = await RoomsServices.getRooms();
    // var hostels = await HostelServices.getHostels();
    // //assign rooms to hostels
    // //randomly assign rooms hostel id to any hostel hostel
    // //after that update the rooms
    // for (var room in rooms) {
    //   var hostel = hostels[faker.randomGenerator.integer(hostels.length - 1)];
    //   room.hostelId = hostel.id;
    //   await RoomsServices.updateRoom(room: room);
    // }
  });
}
