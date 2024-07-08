import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/config/routes/router.dart';
import 'package:unidwell_finder/config/routes/router_item.dart';
import 'package:unidwell_finder/core/views/custom_button.dart';
import 'package:unidwell_finder/core/views/custom_dialog.dart';
import 'package:unidwell_finder/features/auth/providers/user_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);

    return Container(
      width: styles.width,
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

  Widget buildHorizontal() {
    var styles = Styles(context);
    var user = ref.watch(userProvider);
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, '/room/${widget.room.id}');
      },
      child: Container(
        width: styles.width,
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
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.room.images[0],
                fit: BoxFit.cover,
                width: styles.width,
                height: 200,
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
                                  CustomButton(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      text: 'Book Now',
                                      onPressed: () {
                                        if (user.id.isNotEmpty) {
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
                                                        RouterItem.loginRoute);
                                              });
                                        }
                                      })
                                ],
                              );
                            });
                      }())
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<double> getRating() async {
    var rating = await RatingServices.getRoomRating(widget.room.id);
    var total = rating.fold(
        0.0, (previousValue, element) => previousValue + element.rating);
    return total / rating.length;
  }
}
