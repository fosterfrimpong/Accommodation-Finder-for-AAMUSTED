class RouterItem {
  String path;
  String name;
  bool allowAccess;

  RouterItem({
    required this.path,
    required this.name,
    this.allowAccess = true,
  });

  static RouterItem homeRoute = RouterItem(path: '/home', name: 'home');
  static RouterItem loginRoute = RouterItem(path: '/login', name: 'login');
  static RouterItem registerRoute =
      RouterItem(path: '/register', name: 'register');

  static RouterItem forgotPasswordRoute = RouterItem(
      path: '/forgot-password', name: 'forgot-password', allowAccess: false);
  static RouterItem settingsRoute =
      RouterItem(path: '/settings', name: 'settings', allowAccess: false);

  static RouterItem contactRoute =
      RouterItem(path: '/contact', name: 'contact');
  static RouterItem dashboardRoute =
      RouterItem(path: '/dashboard', name: 'dashboard', allowAccess: false);
  static RouterItem profileRoute =
      RouterItem(path: '/profile', name: 'profile', allowAccess: false);

  static RouterItem roomsRoute =
      RouterItem(path: '/rooms', name: 'rooms', allowAccess: false);
  static RouterItem studentsRoute =
      RouterItem(path: '/students', name: 'students', allowAccess: false);
  static RouterItem landloardsRoute =
      RouterItem(path: '/landloards', name: 'landloards', allowAccess: false);
  static RouterItem hostelsRoute =
      RouterItem(path: '/hostels', name: 'hostels', allowAccess: false);
  static RouterItem institutionsRoute = RouterItem(
    path: '/institutions',
    name: 'institutions',
    allowAccess: false,
  );
  static RouterItem bookingsRoute =
      RouterItem(path: '/bookings', name: 'bookings', allowAccess: false);  
  static RouterItem complaintsRoute =
      RouterItem(path: '/complaints', name: 'complaints', allowAccess: false);
  static List<RouterItem> get allRoutes => [
        homeRoute,
        loginRoute,
        registerRoute,
        profileRoute,
        settingsRoute,
        contactRoute,
        dashboardRoute,
        forgotPasswordRoute,
        roomsRoute,
        studentsRoute,
        landloardsRoute,
        hostelsRoute,
        institutionsRoute,
        bookingsRoute,
        complaintsRoute,
      ];

  static RouterItem getRouteByPath(String fullPath) {
    return allRoutes.firstWhere((element) => element.path == fullPath);
  }
}
