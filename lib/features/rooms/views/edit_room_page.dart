import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unidwell_finder/features/dashboard/provider/main_provider.dart';
import 'package:unidwell_finder/features/rooms/data/rooms_model.dart';
import 'package:unidwell_finder/features/rooms/provider/room_provider.dart';
import 'package:unidwell_finder/utils/styles.dart';
import '../../../core/constatnts/options_list.dart';
import '../../../core/views/custom_button.dart';
import '../../../core/views/custom_drop_down.dart';
import '../../../core/views/custom_input.dart';
import '../../../utils/colors.dart';

class EditRoom extends ConsumerStatefulWidget {
  const EditRoom({super.key, required this.room});
  final RoomsModel room;

  @override
  ConsumerState<EditRoom> createState() => _EditRoomState();
}

class _EditRoomState extends ConsumerState<EditRoom> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var notifier = ref.read(editRoomProvider.notifier);
    var myHostels = ref.watch(hostelsFilterProvider).items;
    var hostelNames = myHostels.map((e) => e.name).toList();
    var images = ref.watch(roomImagesProvider);
    //check if the widget is build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifier.setRoom(widget.room);
    });
    var provider = ref.watch(editRoomProvider);
    return Scaffold(
        backgroundColor: Colors.transparent,
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'New Room'.toUpperCase(),
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
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomDropDown(
                                  items: hostelNames
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  label: 'Hostel',
                                  hintText: 'Select Hostel',
                                  value: provider.hostelName,
                                  validator: (hostel) {
                                    if (hostel == null || hostel.isEmpty) {
                                      return 'Hostel is required';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 22),
                                CustomTextFields(
                                  label: 'Listening Title',
                                  hintText: 'Enter Room Title',
                                  initialValue: widget.room.title,
                                  validator: (title) {
                                    if (title == null || title.isEmpty) {
                                      return 'Title is required';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    notifier.setRoomTitle(value);
                                  },
                                ),
                                const SizedBox(height: 22),
                                CustomTextFields(
                                  label: 'Listening Description',
                                  hintText: 'Enter Room Description',
                                  maxLines: 3,
                                  initialValue: widget.room.description,
                                  validator: (description) {
                                    if (description == null ||
                                        description.isEmpty) {
                                      return 'Description is required';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    notifier.setRoomDescription(value);
                                  },
                                ),
                                const SizedBox(height: 22),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextFields(
                                        label: 'Room Capacity',
                                        hintText: 'Enter Room Capacity',
                                        initialValue:
                                            widget.room.capacity.toString(),
                                        isDigitOnly: true,
                                        max: 2,
                                        validator: (capacity) {
                                          if (capacity == null ||
                                              capacity.isEmpty) {
                                            return 'Capacity is required';
                                          }
                                          return null;
                                        },
                                        onSaved: (capacity) {
                                          notifier.setRoomCapacity(capacity);
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CustomTextFields(
                                        label: 'Room Price(GHS)',
                                        hintText: 'Enter Room Price',
                                        isDigitOnly: true,
                                        initialValue: widget.room.price.toString(),
                                        validator: (price) {
                                          if (price == null || price.isEmpty) {
                                            return 'Price is required';
                                          }
                                          return null;
                                        },
                                        onSaved: (price) {
                                          notifier.setRoomPrice(price);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 22),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomDropDown(
                                          items: roomTypeList
                                              .map((e) => DropdownMenuItem(
                                                  value: e, child: Text(e)))
                                              .toList(),
                                          label: 'Room Type',
                                          value: provider.roomType,
                                          hintText: 'Select Room Type',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Room Type is required';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            notifier.setRoomType(value);
                                          }),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CustomDropDown(
                                          items: bedTypeList
                                              .map((e) => DropdownMenuItem(
                                                  value: e, child: Text(e)))
                                              .toList(),
                                          label: 'Bed Type',
                                          hintText: 'Select Bed Type',
                                          value: provider.bedType,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Bed Type is required';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            notifier.setBedType(value);
                                          }),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 22),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomDropDown(
                                          items: bathroomTypeList
                                              .map((e) => DropdownMenuItem(
                                                  value: e, child: Text(e)))
                                              .toList(),
                                          label: 'Bathroom Type',
                                          hintText: 'Select Bathroom Type',
                                          value: provider.bathroomType,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Bathroom Type is required';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            notifier.setBathroomType(value);
                                          }),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: CustomDropDown(
                                          items: kitchingTypeList
                                              .map((e) => DropdownMenuItem(
                                                  value: e, child: Text(e)))
                                              .toList(),
                                          label: 'Kitchen Type',
                                          hintText: 'Select Kitchen Type',
                                          value: provider.kitchingType,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Kitchen Type is required';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            notifier.setKitchenType(value);
                                          }),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 22),
                                //check box for features an rules
                                Row(
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                          title: const Text(
                                              'Select what features are available'),
                                          contentPadding: EdgeInsets.zero,
                                          subtitle: Column(
                                            children: featuresList
                                                .sublist(6)
                                                .map((e) => Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 5),
                                                      child: Row(
                                                        children: [
                                                          Checkbox(
                                                            checkColor:
                                                                primaryColor,
                                                            value: provider
                                                                .features
                                                                .contains(e),
                                                            onChanged: (value) {
                                                              if (value!) {
                                                                notifier
                                                                    .addFeature(
                                                                        e);
                                                              } else {
                                                                notifier
                                                                    .removeFeature(
                                                                        e);
                                                              }
                                                            },
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Text(e)
                                                        ],
                                                      ),
                                                    ))
                                                .toList(),
                                          )),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: ListTile(
                                          title: const Text(
                                              'Select what is not allowed'),
                                          contentPadding: EdgeInsets.zero,
                                          subtitle: Column(
                                            children: rules
                                                .map((e) => Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 5),
                                                      child: Row(
                                                        children: [
                                                          Checkbox(
                                                              checkColor:
                                                                  primaryColor,
                                                              value: provider
                                                                  .rules
                                                                  .contains(e),
                                                              onChanged:
                                                                  (value) {
                                                                if (value!) {
                                                                  notifier
                                                                      .addRule(
                                                                          e);
                                                                } else {
                                                                  notifier
                                                                      .removeRule(
                                                                          e);
                                                                }
                                                              }),
                                                          const SizedBox(
                                                              width: 10),
                                                          Text(e)
                                                        ],
                                                      ),
                                                    ))
                                                .toList(),
                                          )),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 22),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text(
                                          'Select at least 3 images of the room'),
                                      const SizedBox(width: 10),
                                      TextButton(
                                          onPressed: () {
                                            _pickImage();
                                          },
                                          child: const Text('Select Image'))
                                    ],
                                  ),
                                  subtitle: ref
                                          .watch(roomImagesProvider)
                                          .isEmpty
                                      ? provider.images.isEmpty
                                          ? const SizedBox()
                                          : SizedBox(
                                              height: 140,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      provider.images.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var image =
                                                        provider.images[index];
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      child: SizedBox(
                                                        height: 130,
                                                        width: 100,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              width: 100,
                                                              height: 100,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: NetworkImage(
                                                                        image),
                                                                    fit: BoxFit
                                                                        .cover),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            )
                                      : SizedBox(
                                          height: 140,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: images.length,
                                              itemBuilder: (context, index) {
                                                var image = images[index];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: SizedBox(
                                                    height: 130,
                                                    width: 100,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: 100,
                                                          height: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                            image: DecorationImage(
                                                                image:
                                                                    MemoryImage(
                                                                        image),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            ref
                                                                .read(roomImagesProvider
                                                                    .notifier)
                                                                .removeImage(
                                                                    index);
                                                          },
                                                          child: Text(
                                                            'Remove',
                                                            style: styles.body(
                                                                color:
                                                                    Colors.red,
                                                                desktop: 15),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                ),
                                const SizedBox(height: 22),
                                CustomButton(
                                  text: 'Update Room',
                                  radius: 10,
                                  color: primaryColor,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      //save room
                                      ref
                                          .read(editRoomProvider.notifier)
                                          .updateRoom(
                                              ref: ref, context: context);
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void _pickImage() async {
    var image = await ImagePicker().pickMultiImage(limit: 4);
    if (image.isNotEmpty) {
      for (var img in image) {
        var bytes = await img.readAsBytes();
        ref.read(roomImagesProvider.notifier).addImage(bytes);
      }
    }
  }
}
