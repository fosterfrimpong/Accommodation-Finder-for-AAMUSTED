import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/features/dashboard/provider/main_provider.dart';
import 'package:unidwell_finder/features/dashboard/views/components/dasboard_item.dart';
import 'package:unidwell_finder/utils/colors.dart';
import 'package:unidwell_finder/utils/styles.dart';
import '../../auth/providers/user_provider.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var user = ref.watch(userProvider);
    var studentsList = ref.watch(studentsFilterProvider);
    var managersList = ref.watch(managersFilterProvider);
    var bookingsList = ref.watch(bookingFilterProvider(user.id));
    var roomsList = ref.watch(roomsFilterProvider);
    var hostelList = ref.watch(hostelsFilterProvider);
    return Container(
        color: Colors.white,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              const SizedBox(height: 20),
              Text(
                'Dashboard'.toUpperCase(),
                style: styles.title(color: primaryColor),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children:[
                DashBoardItem(
                  icon: Icons.people,
                  title: 'Students'.toUpperCase(),
                  itemCount: studentsList.items.length,
                  color: Colors.blue,
                  onTap: () {},
                ),
                if(user.role == 'admin')
                DashBoardItem(
                  icon: Icons.people_alt_outlined,
                  title: 'Managers'.toUpperCase(),
                  itemCount: managersList.items.length,
                  color: Colors.green,
                  onTap: () {},
                ),
                DashBoardItem(
                  icon: Icons.hotel,
                  title: 'Hostels'.toUpperCase(),
                  itemCount: hostelList.items.length,
                  color: Colors.orange,
                  onTap: () {},
                ),
                DashBoardItem(
                  icon: Icons.room,
                  title: 'Rooms'.toUpperCase(),
                  itemCount: roomsList.items.length,
                  color: Colors.pink,
                  onTap: () {},
                ),
                DashBoardItem(
                  icon: Icons.report,
                  title: 'Bookings'.toUpperCase(),
                  itemCount: bookingsList.items.length,
                  color: Colors.purple,
                  onTap: () {},
                ),
              ],
                  ),
            ])));
  }
}
