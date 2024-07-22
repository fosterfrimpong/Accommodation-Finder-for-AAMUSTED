import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/core/views/custom_button.dart';
import 'package:unidwell_finder/core/views/custom_dialog.dart';
import 'package:unidwell_finder/core/views/custom_input.dart';
import 'package:unidwell_finder/utils/colors.dart';

import '../../../utils/styles.dart';
import '../provider/institution_provider.dart';

class InstitutionsPage extends ConsumerStatefulWidget {
  const InstitutionsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InstitutionsPageState();
}

class _InstitutionsPageState extends ConsumerState<InstitutionsPage> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var titleStyles = styles.title(
        color: Colors.white,
        fontFamily: 'Raleway',
        desktop: 16,
        mobile: 14,
        tablet: 14);
    var rowStyles = styles.body(desktop: 13, mobile: 12, tablet: 12);
var items = ref.watch(institutionsProvider).filteredItems;
    return Container(
        color: Colors.white,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if ((styles.isMobile && !ref.watch(isSearching)) ||
                    styles.largerThanMobile)
                  Text(
                    'Institutions'.toUpperCase(),
                    style: styles.title(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway'),
                  ),
                const Spacer(),
                if (!ref.watch(isNew) && styles.largerThanMobile ||
                    (styles.isMobile && ref.watch(isSearching)))
                  SizedBox(
                    width: styles.isMobile ? styles.width * .88 : 550,
                    child: CustomTextFields(
                      label: 'Search Institution',
                      suffixIcon: styles.isMobile
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                ref.read(isSearching.notifier).state =
                                    false;
                                ref
                                    .read(institutionsProvider.notifier)
                                    .filterItems('');
                              },
                            )
                          : null,
                      onChanged: (query) {
                        ref
                            .read(institutionsProvider.notifier)
                            .filterItems(query);
                      },
                    ),
                  ),
                if (styles.isMobile &&
                    !ref.watch(isSearching) &&
                    !ref.watch(isNew))
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      ref.read(isSearching.notifier).state = true;
                    },
                  ),
                if (!ref.watch(isNew) && styles.largerThanMobile ||
                    (!ref.watch(isNew) &&
                        styles.isMobile &&
                        !ref.watch(isSearching)))
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      color: secondaryColor,
                      radius: 10,
                      text: '',
                      icon: const Icon(
                        Icons.add,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        ref.read(isNew.notifier).state = true;
                      },
                    ),
                  )
              ],
            ),
            const SizedBox(height: 10),
            if (ref.watch(isNew)) buildNewForm(),
            Expanded(
                child:
                      
                       DataTable2(
                          columnSpacing: 20,
                          horizontalMargin: 12,
                          empty: Center(
                              child: Text(
                            'No institutions found',
                            style: rowStyles,
                          )),
                          minWidth: 600,
                          headingRowColor: WidgetStateColor.resolveWith(
                              (states) => primaryColor.withOpacity(0.6)),
                          headingTextStyle: titleStyles,
                          columns: [
                            DataColumn2(
                                label: Text(
                                  'INDEX',
                                  style: titleStyles,
                                ),
                                fixedWidth:
                                    styles.largerThanMobile ? 80 : null),
                            DataColumn(
                              label: Text(
                                'NAME',
                                style: titleStyles,
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'LOCATION',
                                style: titleStyles,
                              ),
                            ),
                            DataColumn2(
                                label: Text(
                                  'LATITUDE',
                                  style: titleStyles,
                                ),
                                fixedWidth:
                                    styles.largerThanMobile ? 180 : null),
                            DataColumn2(
                                label: Text(
                                  'LONGITUDE',
                                  style: titleStyles,
                                ),
                                fixedWidth:
                                    styles.largerThanMobile ? 180 : null),
                            //action
                            DataColumn2(
                                label: Text(
                                  'ACTION',
                                  style: titleStyles,
                                ),
                                size: ColumnSize.S,
                                fixedWidth: 100),
                          ],
                          rows: items.map((item) {
                            var selected =
                                ref.watch(selectedInstitutionProvider);
                            var selectedNotifer =
                                ref.read(selectedInstitutionProvider.notifier);
                            if (selected != null && selected.id == item.id) {
                              return DataRow(cells: [
                                DataCell(Text(
                                  '...',
                                  style: rowStyles,
                                )),
                                DataCell(Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: CustomTextFields(
                                    //controller: TextEditingController(text: ''),
                                    initialValue: item.name,
                                    onChanged: (value) {
                                      selectedNotifer.setName(value);
                                    },
                                  ),
                                )),
                                DataCell(Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: CustomTextFields(
                                    initialValue: item.location,
                                    onChanged: (value) {
                                      selectedNotifer.setLoction(value);
                                    },
                                  ),
                                )),
                                DataCell(Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: CustomTextFields(
                                    initialValue: item.lat.toString(),
                                    isDigitOnly: true,
                                    onChanged: (value) {
                                      selectedNotifer
                                          .setLat(double.parse(value));
                                    },
                                  ),
                                )),
                                DataCell(Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: CustomTextFields(
                                    initialValue: item.long.toString(),
                                    isDigitOnly: true,
                                    onChanged: (value) {
                                      selectedNotifer
                                          .setLong(double.parse(value));
                                    },
                                  ),
                                )),
                                DataCell(Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: IconButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.green),
                                          foregroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.white),
                                          padding: WidgetStateProperty.all(
                                              const EdgeInsets.all(5)),
                                        ),
                                        icon: const Icon(Icons.save),
                                        onPressed: () {
                                          CustomDialogs.showDialog(
                                            message:
                                                'Are you sure you want to update this institution?',
                                            secondBtnText: 'Update',
                                            type: DialogType.warning,
                                            onConfirm: () {
                                              ref
                                                  .read(institutionsProvider
                                                      .notifier)
                                                  .updateInstitution(ref);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    IconButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(Colors.red),
                                        foregroundColor:
                                            WidgetStateProperty.all(
                                                Colors.white),
                                        padding: WidgetStateProperty.all(
                                            const EdgeInsets.all(5)),
                                      ),
                                      icon: const Icon(Icons.cancel),
                                      onPressed: () {
                                        selectedNotifer.removeItem();
                                      },
                                    ),
                                  ],
                                )),
                              ]);
                            } else {
                              var index = items.indexOf(item) + 1;
                              return DataRow(
                                cells: [
                                  DataCell(Text(
                                    '$index',
                                    style: rowStyles,
                                  )),
                                  DataCell(Text(
                                    item.name,
                                    style: rowStyles,
                                  )),
                                  DataCell(Text(
                                    item.location,
                                    style: rowStyles,
                                  )),
                                  DataCell(Text(
                                    item.lat.toStringAsFixed(4),
                                    style: rowStyles,
                                  )),
                                  DataCell(Text(
                                    item.long.toStringAsFixed(4),
                                    style: rowStyles,
                                  )),
                                  DataCell(Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          ref
                                              .read(selectedInstitutionProvider
                                                  .notifier)
                                              .selectInstitution(item);
                                        },
                                      ),
                                      const SizedBox(width: 10),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          CustomDialogs.showDialog(
                                            message:
                                                'Are you sure you want to delete this institution?',
                                            secondBtnText: 'Delete',
                                            type: DialogType.warning,
                                            onConfirm: () {
                                              ref
                                                  .read(institutionsProvider
                                                      .notifier)
                                                  .deleteInstitution(item);
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  )),
                                ],
                              );
                            }
                          }).toList())
                   ),
          ],
        ));
  }

  final formKey = GlobalKey<FormState>();
  Widget buildNewForm() {
    var styles = Styles(context);
    var width = styles.isMobile
        ? double.infinity
        : styles.isTablet
            ? styles.width * 0.3
            : styles.width * 0.2;
    var notifier = ref.read(newInstitutionProvider.notifier);
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 10,
          runSpacing: 22,
          alignment: WrapAlignment.center,
          children: [
            SizedBox(
              width: width,
              child: CustomTextFields(
                label: 'Name',
                validator: (name) {
                  if (name == null || name.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                onSaved: (value) {
                  notifier.setName(value.toString());
                },
              ),
            ),
            SizedBox(
              width: width,
              child: CustomTextFields(
                label: 'Location',
                validator: (location) {
                  if (location == null || location.isEmpty) {
                    return 'Location is required';
                  }
                  return null;
                },
                onSaved: (value) {
                  notifier.setLoction(value.toString());
                },
              ),
            ),
            SizedBox(
              width: 200,
              child: CustomTextFields(
                label: 'Latitude',
                isDigitOnly: true,
                validator: (lat) {
                  if (lat == null || lat.isEmpty) {
                    return 'Latitude is required';
                  }
                  return null;
                },
                onSaved: (value) {
                  notifier.setLat(double.parse(value.toString()));
                },
              ),
            ),
            SizedBox(
              width: 200,
              child: CustomTextFields(
                label: 'Longitude',
                isDigitOnly: true,
                validator: (long) {
                  if (long == null || long.isEmpty) {
                    return 'Longitude is required';
                  }
                  return null;
                },
                onSaved: (value) {
                  notifier.setLong(double.parse(value.toString()));
                },
              ),
            ),
            SizedBox(
              width: 180,
              child: CustomButton(
                color: secondaryColor,
                radius: 10,
                text: 'Add Institution',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    notifier.saveInstitution(
                      ref,
                    );
                    //clear form
                    formKey.currentState!.reset();
                  }
                },
              ),
            ),
            TextButton(
                onPressed: () {
                  ref.read(isNew.notifier).state = false;
                },
                child:
                    const Text('Cancel', style: TextStyle(color: Colors.red))),
          ],
        ),
      ),
    );
  }
}
