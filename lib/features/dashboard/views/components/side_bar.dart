import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/config/routes/router.dart';
import 'package:unidwell_finder/config/routes/router_item.dart';
import 'package:unidwell_finder/features/auth/providers/user_provider.dart';
import 'package:unidwell_finder/features/dashboard/views/components/side_bar_item.dart';
import 'package:unidwell_finder/utils/colors.dart';
import 'package:unidwell_finder/utils/styles.dart';

class SideBar extends ConsumerWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var styles = Styles(context);
    var user = ref.watch(userProvider);
    return Container(
        width: 200,
        height: styles.height,
        color: primaryColor,
        child: Column(children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
                text: TextSpan(
                    text: 'Hello, \n',
                    style: styles.body(
                        color: Colors.white38, fontFamily: 'Raleway'),
                    children: [
                  TextSpan(
                      text: ref.watch(userProvider).name,
                      style: styles.subtitle(
                          fontWeight: FontWeight.bold,
                          desktop: 16,
                          mobile: 13,
                          tablet: 14,
                          color: Colors.white,
                          fontFamily: 'Raleway'))
                ])),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: user.role == 'admin'
                ? buildAdminManu(ref, context)
                : user.role == 'manager'
                    ? buildManagerManu(ref, context)
                    : buildUserManu(ref, context),
            ),
          // footer
          Text('© 2024 All rights reserved',
              style: styles.body(
                  color: Colors.white38, desktop: 12, fontFamily: 'Raleway')),
        ]));
  }

  Widget buildAdminManu(WidgetRef ref, BuildContext context) {
    return Column(
      children: [
        SideBarItem(
          title: 'Dashboard',
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          icon: Icons.dashboard,
          isActive: ref.watch(routerProvider) == RouterItem.dashboardRoute.name,
          onTap: () {
            MyRouter(context: context, ref: ref)
                .navigateToRoute(RouterItem.dashboardRoute);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: SideBarItem(
            title: 'Managers',
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            icon: Icons.admin_panel_settings,
            isActive:
                ref.watch(routerProvider) == RouterItem.landloardsRoute.name,
            onTap: () {
              MyRouter(context: context, ref: ref)
                  .navigateToRoute(RouterItem.landloardsRoute);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: SideBarItem(
            title: 'Students',
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            icon: Icons.people,
            isActive:
                ref.watch(routerProvider) == RouterItem.studentsRoute.name,
            onTap: () {
              MyRouter(context: context, ref: ref)
                  .navigateToRoute(RouterItem.studentsRoute);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: SideBarItem(
            title: 'Hostels',
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            icon: Icons.hotel,
            isActive: ref.watch(routerProvider) == RouterItem.hostelsRoute.name,
            onTap: () {
              MyRouter(context: context, ref: ref)
                  .navigateToRoute(RouterItem.hostelsRoute);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: SideBarItem(
            title: 'Rooms',
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            icon: Icons.room_service,
            isActive: ref.watch(routerProvider) == RouterItem.roomsRoute.name,
            onTap: () {
              MyRouter(context: context, ref: ref)
                  .navigateToRoute(RouterItem.roomsRoute);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: SideBarItem(
            title: 'Bookings',
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            icon: Icons.book_online,
            isActive:
                ref.watch(routerProvider) == RouterItem.bookingsRoute.name,
            onTap: () {
              MyRouter(context: context, ref: ref)
                  .navigateToRoute(RouterItem.bookingsRoute);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: SideBarItem(
            title: 'Instiutions',
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            icon: Icons.school,
            isActive:
                ref.watch(routerProvider) == RouterItem.institutionsRoute.name,
            onTap: () {
              MyRouter(context: context, ref: ref)
                  .navigateToRoute(RouterItem.institutionsRoute);
            },
          ),
        ),
        //complaints
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: SideBarItem(
            title: 'Complaints',
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            icon: Icons.list_alt,
            isActive:
                ref.watch(routerProvider) == RouterItem.complaintsRoute.name,
            onTap: () {
              MyRouter(context: context, ref: ref)
                  .navigateToRoute(RouterItem.complaintsRoute);
            },
          ),
        ),
      ],
    );
  }

  Widget buildUserManu(WidgetRef ref, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: SideBarItem(
            title: 'My Hostels',
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            icon: Icons.book_online,
            isActive:
                ref.watch(routerProvider) == RouterItem.bookingsRoute.name,
            onTap: () {
              MyRouter(context: context, ref: ref)
                  .navigateToRoute(RouterItem.bookingsRoute);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: SideBarItem(
            title: 'Complaints',
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            icon: Icons.list_alt,
            isActive:
                ref.watch(routerProvider) == RouterItem.complaintsRoute.name,
            onTap: () {
              MyRouter(context: context, ref: ref)
                  .navigateToRoute(RouterItem.complaintsRoute);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: SideBarItem(
            title: 'Profile',
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            icon: Icons.person,
            isActive: ref.watch(routerProvider) == RouterItem.profileRoute.name,
            onTap: () {
              MyRouter(context: context, ref: ref)
                  .navigateToRoute(RouterItem.profileRoute);
            },
          ),
        ),
      ],
    );
  }

  Widget buildManagerManu(WidgetRef ref, BuildContext context) {
    return Column(
      children: [
         SideBarItem(
          title: 'Dashboard',
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          icon: Icons.dashboard,
          isActive: ref.watch(routerProvider) == RouterItem.dashboardRoute.name,
          onTap: () {
            MyRouter(context: context, ref: ref)
                .navigateToRoute(RouterItem.dashboardRoute);
          },
        ),
         Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: SideBarItem(
            title: 'Hostels',
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            icon: Icons.hotel,
            isActive: ref.watch(routerProvider) == RouterItem.hostelsRoute.name,
            onTap: () {
              MyRouter(context: context, ref: ref)
                  .navigateToRoute(RouterItem.hostelsRoute);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: SideBarItem(
            title: 'Rooms',
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            icon: Icons.room_service,
            isActive: ref.watch(routerProvider) == RouterItem.roomsRoute.name,
            onTap: () {
              MyRouter(context: context, ref: ref)
                  .navigateToRoute(RouterItem.roomsRoute);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: SideBarItem(
            title: 'Bookings',
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            icon: Icons.book_online,
            isActive:
                ref.watch(routerProvider) == RouterItem.bookingsRoute.name,
            onTap: () {
              MyRouter(context: context, ref: ref)
                  .navigateToRoute(RouterItem.bookingsRoute);
            },
          ),
        ),
         Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: SideBarItem(
            title: 'Complaints',
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            icon: Icons.list_alt,
            isActive:
                ref.watch(routerProvider) == RouterItem.complaintsRoute.name,
            onTap: () {
              MyRouter(context: context, ref: ref)
                  .navigateToRoute(RouterItem.complaintsRoute);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: SideBarItem(
            title: 'Profile',
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            icon: Icons.person,
            isActive: ref.watch(routerProvider) == RouterItem.profileRoute.name,
            onTap: () {
              MyRouter(context: context, ref: ref)
                  .navigateToRoute(RouterItem.profileRoute);
            },
          ),
        ),
      ],
    );
  }
}
