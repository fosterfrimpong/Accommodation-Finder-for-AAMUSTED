import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/core/views/custom_drop_down.dart';
import 'package:unidwell_finder/core/views/custom_input.dart';
import 'package:unidwell_finder/features/dashboard/provider/main_provider.dart';
import 'package:unidwell_finder/utils/colors.dart';
import 'package:unidwell_finder/utils/styles.dart';

import '../../../core/constatnts/options_list.dart';
import '../provider/room_provider.dart';

class NewRoomPage extends ConsumerStatefulWidget {
  const NewRoomPage({super.key});

  @override
  ConsumerState<NewRoomPage> createState() => _NewRoomPageState();
}

class _NewRoomPageState extends ConsumerState<NewRoomPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var notifier = ref.read(newRoomProvider.notifier);
    var myHostels = ref.watch(hostelsFilterProvider).items;
    var hostelNames = myHostels.map((e) => e.name).toList();
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
                        : styles.width * 0.4,
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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomDropDown(
                              items: hostelNames
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e)))
                                  .toList(),
                              label: 'Hostel',
                              onChanged: (value) {
                                var hostel = myHostels
                                    .where((element) => element.name == value)
                                    .firstOrNull;
                                if (hostel != null) {
                                  notifier.setHostel(hostel);
                                }
                              }),
                          const SizedBox(height: 22),
                          CustomTextFields(
                            label: 'Listening Title',
                            hintText: 'Enter Room Title',
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
                                  isCapitalized: true,
                                  isDigitOnly: true,
                                  max: 1,
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
                                  label: 'Room Price',
                                  hintText: 'Enter Room Price',
                                  isDigitOnly: true,
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
                                    hintText: 'Select Room Type',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
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
                                          .map((e) => CheckboxListTile(
                                                title: Text(e),
                                                value: ref
                                                    .watch(newRoomProvider)
                                                    .features
                                                    .contains(e),
                                                onChanged: (value) {
                                                  if (value!) {
                                                    notifier.addFeature(e);
                                                  } else {
                                                    notifier.removeFeature(e);
                                                  }
                                                },
                                              ))
                                          .toList(),
                                    )),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ListTile(
                                    title: const Text(
                                        'Select what rules are available'),
                                    contentPadding: EdgeInsets.zero,
                                    subtitle: Column(
                                      children: featuresList
                                          .map((e) => CheckboxListTile(
                                                title: Text(e),
                                                value: ref
                                                    .watch(newRoomProvider)
                                                    .features
                                                    .contains(e),
                                                onChanged: (value) {
                                                  if (value!) {
                                                    notifier.addFeature(e);
                                                  } else {
                                                    notifier.removeFeature(e);
                                                  }
                                                },
                                              ))
                                          .toList(),
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
