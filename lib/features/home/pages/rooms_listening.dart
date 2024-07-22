import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/features/home/pages/room_card.dart';
import 'package:unidwell_finder/utils/colors.dart';
import 'package:unidwell_finder/utils/styles.dart';
import '../../../core/views/custom_input.dart';
import '../provider/user_rooms_provider.dart';

class RoomsListPage extends ConsumerStatefulWidget {
  const RoomsListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoomsListPageState();
}

class _RoomsListPageState extends ConsumerState<RoomsListPage> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var roomsStream = ref.watch(roomsStreamProvider);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if ((styles.smallerThanTablet &&
                    !ref.watch(userIsSearchingProvider)) ||
                !styles.smallerThanTablet)
              Text(
                'Available Rooms',
                style: styles.title(
                    color: primaryColor, desktop: 26, tablet: 22, mobile: 18),
              ),
            // if ((styles.smallerThanTablet &&
            //         !ref.watch(userIsSearchingProvider)) ||
            //     !styles.smallerThanTablet)
            const Spacer(),
            if ((styles.smallerThanTablet &&
                    ref.watch(userIsSearchingProvider)) ||
                !styles.smallerThanTablet)
              SizedBox(
                  width: styles.isMobile
                      ? 280
                      : styles.isTablet
                          ? 450
                          : 500,
                  child: CustomTextFields(
                    hintText: 'Search a room',
                    onChanged: (value) {
                      ref
                          .read(userRoomsFilterProvider.notifier)
                          .filterRooms(value);
                    },
                  )),
            const SizedBox(width: 10),
            if (styles.smallerThanTablet)
              IconButton(
                style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    backgroundColor: WidgetStateProperty.all(primaryColor)),
                onPressed: () {
                  ref.read(userIsSearchingProvider.notifier).state =
                      !ref.watch(userIsSearchingProvider);
                },
                icon: Icon(ref.watch(userIsSearchingProvider)
                    ? Icons.cancel
                    : Icons.search),
              ),
          ],
        ),
        const SizedBox(height: 20),
        roomsStream.when(
            data: (data) {
              var data = ref.watch(userRoomsFilterProvider);
              if (data.filteredItems.isEmpty) {
                return const SizedBox(
                    height: 200,
                    child: Center(child: Text('No Rooms found ')));
              }
              return Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                children: data.filteredItems
                    .map((e) => RoomCard(
                          e,
                        ))
                    .toList(),
              );
            },
            error: (error, stack) {
              return SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Center(child: Text(error.toString())));
            },
            loading: () {
              return const SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ));
            }),
        
      ],
    );
  }
}
