import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/features/home/pages/room_card.dart';
import 'package:unidwell_finder/utils/colors.dart';
import 'package:unidwell_finder/utils/styles.dart';
import '../../../core/views/custom_input.dart';
import '../provider/rooms_provider.dart';

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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if ((styles.smallerThanTablet &&
                      !ref.watch(isSearchingProvider)) ||
                  !styles.smallerThanTablet)
                Text(
                  'Available Rooms',
                  style: styles.title(
                      color: primaryColor, desktop: 26, tablet: 22, mobile: 18),
                ),
              // if ((styles.smallerThanTablet &&
              //         !ref.watch(isSearchingProvider)) ||
              //     !styles.smallerThanTablet)
              const Spacer(),
              if ((styles.smallerThanTablet &&
                      ref.watch(isSearchingProvider)) ||
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
                            .read(roomsFilterProvider.notifier)
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
                    ref.read(isSearchingProvider.notifier).state =
                        !ref.watch(isSearchingProvider);
                  },
                  icon: Icon(ref.watch(isSearchingProvider)
                      ? Icons.cancel
                      : Icons.search),
                ),
            ],
          ),
          const SizedBox(height: 20),
          roomsStream.when(data: (data) {
            var data = ref.watch(roomsFilterProvider);
            if (data.filteredItems.isEmpty) {
              return const SizedBox(
                  height: 200, child: Center(child: Text('No Rooms found ')));
            }
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: styles.width <= 700
                      ? 1
                      : styles.width > 700 && styles.width <= 1100
                          ? 2
                          : styles.width > 1100 && styles.width <= 1500
                              ? 3
                              : 4,
                  childAspectRatio: styles.width <= 700 ? 1.2 : 0.9,
                  crossAxisSpacing: styles.isMobile
                      ? 10
                      : styles.isTablet
                          ? 20
                          : 30,
                  mainAxisSpacing: 10),
              itemCount: data.filteredItems.length,
              itemBuilder: (context, index) {
                var room = data.filteredItems[index];
                return RoomCard(room);
              },
            );
          }, error: (error, stack) {
            return SizedBox(
                height: 200,
                width: double.infinity,
                child: Center(child: Text(error.toString())));
          }, loading: () {
            return const SizedBox(
                height: 200,
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                ));
          })
        ],
      ),
    );
  }
}
