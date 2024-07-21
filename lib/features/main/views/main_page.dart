import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/features/main/components/nav_bar.dart';


class MainPage extends ConsumerWidget {
  const MainPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100), child: NavBar()),
      body: FutureBuilder(
          future: saveDummyData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return child;
          }),
    ));
  }

  Future<void> saveDummyData() async {
    // var institutions = InstitutionsModel.dummyData();
    // for (var institution in institutions) {
    //   institution.id = InstitutionServices.getInstitutionId();
    //   await InstitutionServices.addInstitution(institution);
    // }
    // var users = UserModel.dummyData();
    // for (var user in users) {
    //   user.id = RegistrationServices.getId();
    //   user.createdAt = DateTime.now().millisecondsSinceEpoch;
    //   await RegistrationServices.createUser(user);
    // }
    // var managers = await RegistrationServices.getManagers();
    // var hostels = HostelsModel.dummyHostels();
    // var faker = Faker();
    // for (var hostel in hostels) {
    //   hostel = hostel.copyWith(
    //     id: HostelServices.getId(),
    //     managerId:
    //         faker.randomGenerator.element(managers.map((e) => e.id).toList()),
    //     createdAt: () => DateTime.now().millisecondsSinceEpoch,
    //     managerEmail: faker.randomGenerator
    //         .element(managers.map((e) => e.email).toList()),
    //     managerName:
    //         faker.randomGenerator.element(managers.map((e) => e.name).toList()),
    //     managerPhone: faker.randomGenerator
    //         .element(managers.map((e) => e.phone).toList()),
    //   );
    //   var response = await HostelServices.addHostel(hostel);
    //   print(response);
    // }
  }
}
