import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/features/hostels/provider/hostel_provider.dart';

import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../../institutions/provider/institution_provider.dart';

class NewHostel extends ConsumerStatefulWidget {
  const NewHostel({super.key});

  @override
  ConsumerState<NewHostel> createState() => _NewHostelState();
}

class _NewHostelState extends ConsumerState<NewHostel> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var notifier = ref.read(newHostelProvider.notifier);
    var images = ref.watch(hostelImagesProvider);
    var institutions = ref.watch(institutionsProvider).items;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: styles.isMobile
                  ? styles.width
                  : styles.isTablet
                      ? styles.width * 0.55
                      : styles.width * 0.45,
              height: styles.height * .9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(children: [
                 Row(
                    children: [
                      Expanded(
                        child: Text(
                          'New Hostel'.toUpperCase(),
                          style: styles.title(),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: primaryColor,
                  ),
                  const SizedBox(height: 10),
              ],),
            )
          ],
        ),
      ),
    );
  }
}
