import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/core/views/custom_dialog.dart';
import 'package:unidwell_finder/features/dashboard/provider/main_provider.dart';
import 'package:unidwell_finder/utils/colors.dart';
import 'package:unidwell_finder/utils/styles.dart';

import '../../../core/views/custom_input.dart';
import '../../../generated/assets.dart';
import '../provider/students_provider.dart';

class StudentsPage extends ConsumerStatefulWidget {
  const StudentsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StudentsPageState();
}

class _StudentsPageState extends ConsumerState<StudentsPage> {
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
    var studesnts = ref.watch(studentsFilterProvider).filteredList;
    return Container(
        color: Colors.white,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Row(
            children: [
              if ((styles.isMobile && !ref.watch(isSearchingStudent)) ||
                  styles.largerThanMobile)
                Text(
                  'Students List'.toUpperCase(),
                  style: styles.title(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway'),
                ),
              const Spacer(),
              if (styles.largerThanMobile ||
                  (styles.isMobile && ref.watch(isSearchingStudent)))
                SizedBox(
                  width: styles.isMobile ? styles.width * .88 : 500,
                  child: CustomTextFields(
                    label: 'Search Studnets',
                    suffixIcon: styles.isMobile
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              ref.read(isSearchingStudent.notifier).state =
                                  false;
                              ref
                                  .read(studentsFilterProvider.notifier)
                                  .filterStudents('');
                            },
                          )
                        : null,
                    onChanged: (query) {
                      ref
                          .read(managersFilterProvider.notifier)
                          .filterManagers(query);
                    },
                  ),
                ),
              if (styles.isMobile && !ref.watch(isSearchingStudent))
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    ref.read(isSearchingStudent.notifier).state = true;
                  },
                ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: DataTable2(
                  columnSpacing: 20,
                  horizontalMargin: 12,
                  empty: Center(
                      child: Text(
                    'No Manager found',
                    style: rowStyles,
                  )),
                  minWidth: 600,
                  headingRowColor: WidgetStateColor.resolveWith(
                      (states) => primaryColor.withOpacity(0.6)),
                  headingTextStyle: titleStyles,
                  columns: [
                    DataColumn2(
                        label: Text('Index'.toUpperCase()),
                        size: ColumnSize.S,
                        fixedWidth: styles.isMobile ? null : 80),
                    DataColumn2(
                        label: Text('Image'.toUpperCase()),
                        size: ColumnSize.S,
                        fixedWidth: styles.isMobile ? null : 80),
                    DataColumn2(
                        label: Text('Name'.toUpperCase()),
                        size: ColumnSize.L,
                        onSort: (columnIndex, ascending) {
                          studesnts.sort((a, b) {
                            if (ascending) {
                              return a.name.compareTo(b.name);
                            } else {
                              return b.name.compareTo(a.name);
                            }
                          });
                        }),
                    DataColumn2(
                        label: Text('Gender'.toUpperCase()),
                        size: ColumnSize.S,
                        fixedWidth: styles.isMobile ? null : 100),
                    DataColumn2(
                        label: Text('Email'.toUpperCase()),
                        size: ColumnSize.L,
                        onSort: (columnIndex, ascending) {
                          studesnts.sort((a, b) {
                            if (ascending) {
                              return a.email.compareTo(b.email);
                            } else {
                              return b.email.compareTo(a.email);
                            }
                          });
                        }),
                    DataColumn2(
                        label: Text('Phone'.toUpperCase()),
                        size: ColumnSize.S,
                        fixedWidth: styles.isMobile ? null : 200),
                    DataColumn2(
                        label: Text('Status'.toUpperCase()),
                        size: ColumnSize.S,
                        fixedWidth: styles.isMobile ? null : 100),
                    DataColumn2(
                      label: Text('Current Hostel'.toUpperCase()),
                      size: ColumnSize.M,
                    ),
                    //actions
                    DataColumn2(
                        label: Text('Actions'.toUpperCase()),
                        size: ColumnSize.S,
                        fixedWidth: styles.isMobile ? null : 200),
                  ],
                  rows: studesnts.map((student) {
                    var index = studesnts.indexOf(student) + 1;
                    return DataRow(cells: [
                      DataCell(Text('$index', style: rowStyles)),
                      //image
                      DataCell(Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: student.image != null
                              ? NetworkImage(
                                  student.image!,
                                )
                              : AssetImage(student.gender == 'Male'
                                  ? Assets.imagesMale
                                  : Assets.imagesFemale),
                        ),
                      )),
                      DataCell(Text(student.name, style: rowStyles)),
                      DataCell(Text(student.gender, style: rowStyles)),
                      DataCell(Text(student.email, style: rowStyles)),
                      DataCell(Text(student.phone, style: rowStyles)),
                      DataCell(Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          decoration: BoxDecoration(
                              color: student.status == 'active'
                                  ? Colors.green
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(student.status,
                              style: rowStyles.copyWith(color: Colors.white)))),
                      DataCell(() {
                        var bookings = ref
                            .watch(bookingFilterProvider(student.id))
                            .filter
                            .where((element) =>
                                element.studentId == student.id &&
                                element.status == 'active')
                            .toList();
                        if (bookings.isNotEmpty) {
                          return Text(bookings.first.hostelName!,
                              style: rowStyles.copyWith(color: Colors.green));
                        } else {
                          return Text('Student has no hostel',
                              style: rowStyles.copyWith(color: Colors.red));
                        }
                      }()),
                      DataCell(Row(
                        children: [
                          // //view
                          // IconButton(
                          //     icon: const Icon(Icons.remove_red_eye,
                          //         color: Colors.blue),
                          //     onPressed: () {}),
                          //change status
                          if (student.status == 'active')
                            IconButton(
                                icon:
                                    const Icon(Icons.block, color: Colors.red),
                                onPressed: () {
                                  CustomDialogs.showDialog(
                                      type: DialogType.warning,
                                      secondBtnText: 'Block',
                                      message:
                                          'Are you sure you want to deactivate this manager?',
                                      onConfirm: () {
                                        ref
                                            .read(
                                                studentsFilterProvider.notifier)
                                            .changeStatus(student, 'blocked');
                                      });
                                })
                          else
                            IconButton(
                                icon: const Icon(Icons.check,
                                    color: Colors.green),
                                onPressed: () {
                                  CustomDialogs.showDialog(
                                      type: DialogType.warning,
                                      secondBtnText: 'Activate',
                                      message:
                                          'Are you sure you want to activate this manager?',
                                      onConfirm: () {
                                        ref
                                            .read(
                                                managersFilterProvider.notifier)
                                            .changeStatus(student, 'active');
                                      });
                                }),
                        ],
                      )),
                    ]);
                  }).toList()))
        ]));
  }
}
