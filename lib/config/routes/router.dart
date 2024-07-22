import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unidwell_finder/config/routes/router_item.dart';
import 'package:unidwell_finder/features/auth/views/login_page.dart';
import 'package:unidwell_finder/features/auth/views/registration.dart';
import 'package:unidwell_finder/features/bookings/views/admin_booking_page.dart';
import 'package:unidwell_finder/features/dashboard/views/dashbaord_page.dart';
import 'package:unidwell_finder/features/hostels/views/hostel_page.dart';
import 'package:unidwell_finder/features/profile/views/profile_page.dart';
import '../../features/auth/providers/user_provider.dart';
import '../../features/contact/views/contact_page.dart';
import '../../features/dashboard/views/dashboard_main.dart';
import '../../features/home/views/home_page.dart';
import '../../features/institutions/views/institutions_page.dart';
import '../../features/main/views/main_page.dart';
import '../../features/managers/views/managers_page.dart';
import '../../features/rooms/views/rooms_page.dart';
import '../../features/students/views/students_page.dart';

class MyRouter {
  final WidgetRef ref;
  final BuildContext context;
  MyRouter({
    required this.ref,
    required this.context,
  });
  router() => GoRouter(
          initialLocation: RouterItem.homeRoute.path,
          redirect: (context, state) {
            var route = state.fullPath;
            //check if widget is done building
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (route != null && route.isNotEmpty) {
                var item = RouterItem.getRouteByPath(route);
                ref.read(routerProvider.notifier).state = item.name;
              }
            });
            return null;
          },
          routes: [
            ShellRoute(
                builder: (context, state, child) {
                  return MainPage(
                    child: child,
                  );
                },
                routes: [
                  GoRoute(
                    path: RouterItem.homeRoute.path,
                    builder: (context, state) {
                      return const HomePage();
                    },
                  ),
                  GoRoute(
                      path: RouterItem.contactRoute.path,
                      builder: (context, state) {
                        return const ContactPage();
                      }),
                  //login page
                  GoRoute(
                    path: RouterItem.loginRoute.path,
                    builder: (context, state) {
                      return const LoginPage();
                    },
                  ),

                  GoRoute(
                      path: RouterItem.registerRoute.path,
                      builder: (context, state) {
                        return const RegistrationPage();
                      }),
                ]),
            ShellRoute(
                builder: (context, state, child) {
                  return DashBoardMainPage(
                    child,
                  );
                },
                redirect: (context, state) {
                  var userInfo = ref.watch(userProvider);

                  if (userInfo.id.isEmpty) {
                    return RouterItem.loginRoute.path;
                  }
                  return null;
                },
                routes: [
                  GoRoute(
                    path: RouterItem.profileRoute.path,
                    name: RouterItem.profileRoute.name,
                    builder: (context, state) {
                      return const ProfilePage();
                    },
                  ),
                  GoRoute(
                      path: RouterItem.dashboardRoute.path,
                      builder: (context, state) {
                        return const DashboardPage();
                      }),
                  GoRoute(
                    path: RouterItem.landloardsRoute.path,
                    name: RouterItem.landloardsRoute.name,
                    builder: (context, state) {
                      return const ManagersPage();
                    },
                  ),
                  GoRoute(
                      path: RouterItem.institutionsRoute.path,
                      name: RouterItem.institutionsRoute.name,
                      builder: (context, state) {
                        return const InstitutionsPage();
                      }),
                  GoRoute(
                      path: RouterItem.hostelsRoute.path,
                      name: RouterItem.hostelsRoute.name,
                      builder: (context, state) {
                        return const HostelPage();
                      }),
                  GoRoute(
                      path: RouterItem.studentsRoute.path,
                      name: RouterItem.studentsRoute.name,
                      builder: (context, state) {
                        return const StudentsPage();
                      }),
                  GoRoute(
                      path: RouterItem.roomsRoute.path,
                      name: RouterItem.roomsRoute.name,
                      builder: (context, state) {
                        return const RoomsPage();
                      }),
                  GoRoute(
                      path: RouterItem.bookingsRoute.path,
                      builder: (context, state) {
                        return const AdminBookingPage();
                      }),
                ])
          ]);

  void navigateToRoute(RouterItem item) {
    ref.read(routerProvider.notifier).state = item.name;
    context.go(item.path);
  }

  void navigateToNamed(
      {required Map<String, String> pathParms,
      required RouterItem item,
      Map<String, dynamic>? extra}) {
    ref.read(routerProvider.notifier).state = item.name;
    context.goNamed(item.name, pathParameters: pathParms, extra: extra);
  }
}

final routerProvider = StateProvider<String>((ref) {
  return RouterItem.homeRoute.name;
});
