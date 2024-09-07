import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unidwell_finder/core/views/custom_button.dart';
import 'package:unidwell_finder/features/hostels/provider/hostel_provider.dart';

import '../../../core/views/custom_drop_down.dart';
import '../../../core/views/custom_input.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../../institutions/provider/institution_provider.dart';

class NewHostel extends ConsumerStatefulWidget {
  const NewHostel({super.key});

  @override
  ConsumerState<NewHostel> createState() => _NewHostelState();
}

class _NewHostelState extends ConsumerState<NewHostel> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var notifier = ref.read(newHostelProvider.notifier);
    var images = ref.watch(hostelImagesProvider);
    var institutions = ref.watch(institutionsProvider).items;
    var institutionNames = institutions.map((e) => e.name).toList();
      //remove duplicates
    institutionNames = institutionNames.toSet().toList();
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
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
              height: styles.height * .8,
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
                  Expanded(
                      child: SingleChildScrollView(
                          child: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Form(
                                  key: _formKey,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CustomDropDown(
                                            items: institutionNames
                                                .map((e) => DropdownMenuItem(
                                                    value: e, child: Text(e)))
                                                .toList(),
                                            label: 'Institution',
                                           hintText: 'Select Institution',
                                            validator: (hostel) {
                                              if (hostel == null ||
                                                  hostel.isEmpty) {
                                                return 'Institution is required';
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              var school = institutions
                                                  .where((element) =>
                                                      element.name == value)
                                                  .firstOrNull;
                                              if (school != null) {
                                                notifier.setSchool(school);
                                              }
                                            }),
                                        const SizedBox(height: 22),
                                        CustomTextFields(
                                          label: 'Hostel Name',
                                          hintText: 'Enter Hostel Name',
                                          validator: (title) {
                                            if (title == null ||
                                                title.isEmpty) {
                                              return 'Hostel name is required';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            notifier.setHostelName(value!);
                                          },
                                        ),
                                        const SizedBox(height: 22),
                                        CustomTextFields(
                                          label: 'Hostel Description',
                                          hintText: 'Enter Hoste Description',
                                          maxLines: 3,
                                          validator: (description) {
                                            if (description == null ||
                                                description.isEmpty) {
                                              return 'Description is required';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            notifier
                                                .setHostelDescription(value!);
                                          },
                                        ),
                                        const SizedBox(height: 22),
                                        CustomTextFields(
                                          label: 'Hostel Address',
                                          hintText: 'Enter Hostel Location',
                                          validator: (location) {
                                            if (location == null ||
                                                location.isEmpty) {
                                              return 'Location is required';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            notifier.setHostelLocation(value!);
                                          },
                                        ),
                                        const SizedBox(height: 22),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10,),
                                          child: Text(
                                              'Be at the hostel location and click the button below to get the location coordinates',
                                              style: styles.body(
                                                  color: Colors.grey,
                                                  desktop: 15)),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomTextFields(
                                                label: 'Latitude',
                                                hintText: 'Latitude',
                                                controller: TextEditingController(
                                                    text: ref
                                                        .watch(
                                                            newHostelProvider)
                                                        .lat
                                                        .toString()),
                                                isReadOnly: true,
                                                validator: (latitude) {
                                                  if (latitude == null ||
                                                      latitude.isEmpty) {
                                                    return 'Latitude is required';
                                                  }
                                                  return null;
                                                },
                                                onSaved: (value) {
                                                  notifier.setLatitude(value!);
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: CustomTextFields(
                                                label: 'Longitude',
                                                hintText: 'Longitude',
                                                controller: TextEditingController(
                                                    text: ref
                                                        .watch(
                                                            newHostelProvider)
                                                        .lng
                                                        .toString()),
                                                isReadOnly: true,
                                                validator: (longitude) {
                                                  if (longitude == null ||
                                                      longitude.isEmpty) {
                                                    return 'Longitude is required';
                                                  }
                                                  return null;
                                                },
                                                onSaved: (value) {
                                                  notifier.setLongitude(value!);
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            IconButton(
                                                style: ButtonStyle(
                                                    foregroundColor:
                                                        WidgetStateProperty.all(
                                                            Colors.white),
                                                    backgroundColor:
                                                        WidgetStateProperty.all(
                                                            primaryColor)),
                                                onPressed: () {
                                                  notifier.getLocation();
                                                },
                                                icon: const Icon(
                                                    Icons.location_on))
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
                                                  'Select at least 3 images of the hostel'),
                                              const SizedBox(width: 10),
                                              TextButton(
                                                  onPressed: () {
                                                    _pickImage();
                                                  },
                                                  child: const Text(
                                                      'Select Image'))
                                            ],
                                          ),
                                          subtitle:
                                              ref
                                                      .watch(
                                                          hostelImagesProvider)
                                                      .isEmpty
                                                  ? const SizedBox()
                                                  : SizedBox(
                                                      height: 140,
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount:
                                                              images.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            var image =
                                                                images[index];
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right:
                                                                          10),
                                                              child: SizedBox(
                                                                height: 130,
                                                                width: 100,
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          100,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        image: DecorationImage(
                                                                            image:
                                                                                MemoryImage(image),
                                                                            fit: BoxFit.cover),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        ref.read(hostelImagesProvider.notifier).removeImage(
                                                                            index);
                                                                      },
                                                                      child:
                                                                          Text(
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
                                            text: 'Submit Hostel',
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState!.save();
                                                notifier.saveHostel(
                                                  context: context,
                                                  ref: ref,
                                                );
                                              }
                                            })
                                      ])))))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _pickImage() async {
    var image = await ImagePicker().pickMultiImage(limit: 4);
    if (image.isNotEmpty) {
      for (var img in image) {
        var bytes = await img.readAsBytes();
        ref.read(hostelImagesProvider.notifier).addImage(bytes);
      }
    }
  }
}
