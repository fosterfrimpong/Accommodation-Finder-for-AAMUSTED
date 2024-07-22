import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/config/routes/router.dart';
import 'package:unidwell_finder/config/routes/router_item.dart';
import 'package:unidwell_finder/core/functions/view_on_map.dart';
import 'package:unidwell_finder/core/views/custom_button.dart';
import 'package:unidwell_finder/core/views/custom_dialog.dart';
import 'package:unidwell_finder/features/auth/providers/user_provider.dart';
import 'package:unidwell_finder/features/home/provider/booking_provider.dart';
import 'package:unidwell_finder/features/rooms/data/rooms_model.dart';
import 'package:unidwell_finder/rating/services/rating_services.dart';
import 'package:unidwell_finder/utils/colors.dart';
import 'package:unidwell_finder/utils/styles.dart';

class RoomCard extends ConsumerStatefulWidget {
  const RoomCard(this.room, {super.key});

  final RoomsModel room;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoomCardState();
}

class _RoomCardState extends ConsumerState<RoomCard> {
  final selectedSpaces = StateProvider<int>((ref) => 1);

  Widget buildHorizontal() {
    var styles = Styles(context);
    var user = ref.watch(userProvider);
    var booking = ref.watch(bookingProvider);

    if (booking != null && booking.room!.id == widget.room.id) {
      return buildBookingCover();
    } else {
      return Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 200,
               width: styles.isMobile
                  ? styles.width * .85
                  : styles.isTablet
                      ? styles.width * .4
                      : styles.width * .3,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(widget.room.images[0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.room.title,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: styles.title(
                        color: Colors.white,
                        desktop: 20,
                        tablet: 17,
                        mobile: 18),
                  ),
                  const SizedBox(height: 5),
                  // Text(
                  //   widget.room.location,
                  //   style: styles.subtitle(color: Colors.white),
                  // ),
                  // const SizedBox(height: 5),
                  Text(
                    'GHS ${widget.room.price.toStringAsFixed(2)}',
                    style: styles.title(color: secondaryColor),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.king_bed,
                                    color: Colors.white, size: 20),
                                const SizedBox(width: 3),
                                Text(
                                  ' ${widget.room.bedType}',
                                  style: styles.body(
                                      color: Colors.white,
                                      desktop: 16,
                                      tablet: 14,
                                      mobile: 12),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.bathtub,
                                    color: Colors.white, size: 20),
                                const SizedBox(width: 3),
                                Text(
                                  ' ${widget.room.bathroomType}',
                                  style: styles.body(
                                      color: Colors.white,
                                      desktop: 16,
                                      tablet: 14,
                                      mobile: 12),
                                ),
                              ],
                            ),
                            //kitchen
                            Row(
                              children: [
                                const Icon(Icons.kitchen,
                                    color: Colors.white, size: 20),
                                const SizedBox(width: 3),
                                Text(
                                  ' ${widget.room.kitchingType}',
                                  style: styles.body(
                                      color: Colors.white,
                                      desktop: 16,
                                      tablet: 14,
                                      mobile: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //rating
                      Expanded(child: () {
                        return FutureBuilder(
                            future: getRating(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      for (var i = 0; i < 5; i++)
                                        Icon(
                                          Icons.star,
                                          color: i < snapshot.data!.toInt()
                                              ? Colors.amber
                                              : Colors.white,
                                          size: 20,
                                        ),
                                      const SizedBox(width: 3),
                                      Text(
                                        ' ${snapshot.data!.toStringAsFixed(1)}',
                                        style: styles.body(
                                            color: Colors.white,
                                            desktop: 16,
                                            tablet: 14,
                                            mobile: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  if (widget.room.availableSpace > 0)
                                    CustomButton(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        text: 'Book Now',
                                        onPressed: () {
                                          if (user.id.isNotEmpty) {
                                            ref
                                                .read(bookingProvider.notifier)
                                                .setRoom(widget.room);
                                          } else {
                                            CustomDialogs.showDialog(
                                                message:
                                                    'Please login to book room',
                                                type: DialogType.warning,
                                                secondBtnText: 'Login',
                                                onConfirm: () {
                                                  CustomDialogs.dismiss();
                                                  MyRouter(
                                                          context: context,
                                                          ref: ref)
                                                      .navigateToRoute(
                                                          RouterItem
                                                              .loginRoute);
                                                });
                                          }
                                        }),
                                
                                const SizedBox(height: 5),
                                TextButton(
                                  style: ButtonStyle(
                                    foregroundColor: WidgetStateProperty.all(Colors.white),
                                    padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 10, vertical: 5))
                                  ),
                                  onPressed: (){
                                    if(widget.room.lat != null && widget.room.lng != null) {
                                      openMap(widget.room.lat!, widget.room.lng!);
                                    }else{
                                      CustomDialogs.toast(
                                        message: 'Location not available',
                                        type: DialogType.error
                                      );
                                    }

                                }, child: const Text('View on Map'))
                                ],
                              );
                            });
                      }())
                   
                   
                    ],
                  )
                ],
              ),
            ),
            //show room availability
            if (widget.room.availableSpace > 0)
              Text(
                'Available Room: ${widget.room.availableSpace}/${widget.room.capacity}',
                style:
                    styles.body(color: secondaryColor, desktop: 15, mobile: 13),
              )
            else
              Text(
                'Room is full',
                style: styles.body(color: Colors.red, desktop: 14, mobile: 13),
              ),
              const SizedBox(height: 10),
          ],
        ),
      );
    }
  }

  Future<double> getRating() async {
    var rating = await RatingServices.getRoomRating(widget.room.id);
    if(rating.isEmpty) return 0.0;
    var total = rating.fold(
        0.0, (previousValue, element) => previousValue + element.rating);
    return total / rating.length;
  }

  Widget buildBookingCover() {
    var styles = Styles(context);
    return Container(
       width: styles.isMobile
          ? styles.width * .85
          : styles.isTablet
              ? styles.width * .4
              : styles.width * .3,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    ref.read(bookingProvider.notifier).removeRoom();
                  },
                  icon: const Icon(Icons.cancel, color: Colors.white)),
              const SizedBox(width: 10),
              Text(
                'Booking Room',
                style: styles.title(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 10),
          //list of facilities and features
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListTile(
                  title: Text(
                    'Facilities',
                    style: styles.subtitle(
                        color: Colors.white, fontFamily: 'Ralway'),
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.king_bed,
                              color: Colors.white, size: 20),
                          const SizedBox(width: 3),
                          Text(
                            ' ${widget.room.bedType}',
                            style: styles.body(color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.bathtub,
                              color: Colors.white, size: 20),
                          const SizedBox(width: 3),
                          Text(
                            ' ${widget.room.bathroomType}',
                            style: styles.body(color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.kitchen,
                              color: Colors.white, size: 20),
                          const SizedBox(width: 3),
                          Text(
                            ' ${widget.room.kitchingType}',
                            style: styles.body(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 5),
              //rules
              Expanded(
                child: ListTile(
                  title: Text(
                    'Rules',
                    style: styles.subtitle(
                        color: Colors.white, fontFamily: 'Ralway'),
                  ),
                  subtitle: Column(
                    children: [
                      for (var rule in widget.room.rules)
                        Row(
                          children: [
                            const Icon(Icons.check,
                                color: Colors.white, size: 20),
                            const SizedBox(width: 3),
                            Expanded(
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                ' $rule',
                                style: styles.body(
                                    color: Colors.white, desktop: 15),
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.bedroom_parent, color: Colors.white, size: 20),
              const SizedBox(width: 3),
              Text('Available slots',
                  style: styles.body(color: Colors.white60)),
              Text(' ${widget.room.availableSpace} / ${widget.room.capacity}',
                  style: styles.subtitle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 10),
          //textfield with minus and plus button
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      if (ref.watch(bookingProvider)!.spaces > 1) {
                        ref.read(bookingProvider.notifier).decreaseSpace();
                        //ref.read(isBooking).state = true;
                      }
                    },
                    icon: const Icon(Icons.remove, color: primaryColor)),
                const Spacer(),
                Text(
                  '${ref.watch(bookingProvider)!.spaces}',
                  style: styles.title(color: primaryColor),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      if (ref.watch(bookingProvider)!.spaces <
                          widget.room.capacity) {
                        ref.read(bookingProvider.notifier).increaseSpace();
                        //ref.read(isBooking).state = true;
                      }
                    },
                    icon: const Icon(Icons.add, color: primaryColor)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
              'Additional Cost: GHS ${widget.room.additionalCost.toStringAsFixed(2)}',
              style: styles.body(color: Colors.white60)),
          const SizedBox(height: 10),

          CustomButton(
              color: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 5),
              text:
                  'GHS ${ref.watch(bookingProvider)!.totalCost.toStringAsFixed(2)} Pay Now',
              onPressed: () {
                CustomDialogs.showDialog(
                    message: 'Are you sure you want to book this room?',
                    type: DialogType.warning,
                    secondBtnText: 'Pay Now',
                    onConfirm: () {
                      ref.read(bookingProvider.notifier).book(ref, context);
                    });
              })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);

    return Container(
      width: styles.isMobile
          ? styles.width * .85
          : styles.isTablet
              ? styles.width * .4
              : styles.width * .3,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: buildHorizontal(),
    );
  }
}
