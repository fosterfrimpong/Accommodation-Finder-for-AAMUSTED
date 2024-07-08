import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/core/views/custom_dialog.dart';
import 'package:unidwell_finder/core/views/custom_input.dart';
import 'package:unidwell_finder/features/dashboard/provider/main_provider.dart';
import 'package:unidwell_finder/generated/assets.dart';
import 'package:unidwell_finder/utils/colors.dart';
import '../../../utils/styles.dart';
import '../provider/managers_provider.dart';

class ManagersPage extends ConsumerStatefulWidget {
  const ManagersPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ManagersPageState();
}

class _ManagersPageState extends ConsumerState<ManagersPage> {
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
    var managers = ref.watch(managersFilterProvider).filteredList;
    return Container(
        color: Colors.white,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Row(
            children: [
              if ((styles.isMobile && !ref.watch(isSearchingManagers)) ||
                  styles.largerThanMobile)
                Text(
                  'Property Managers'.toUpperCase(),
                  style: styles.title(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway'),
                ),
              const Spacer(),
              if (styles.largerThanMobile ||
                  (styles.isMobile && ref.watch(isSearchingManagers)))
                SizedBox(
                  width: styles.isMobile ? styles.width * .88 : 500,
                  child: CustomTextFields(
                    label: 'Search Managers',
                    suffixIcon: styles.isMobile
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              ref.read(isSearchingManagers.notifier).state =
                                  false;
                              ref
                                  .read(managersFilterProvider.notifier)
                                  .filterManagers('');
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
              if (styles.isMobile && !ref.watch(isSearchingManagers))
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    ref.read(isSearchingManagers.notifier).state = true;
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
                          managers.sort((a, b) {
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
                          managers.sort((a, b) {
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
                        label: Text('Total Hostels'.toUpperCase()),
                        size: ColumnSize.S,
                        fixedWidth: styles.isMobile ? null : 180),
                    //actions
                    DataColumn2(
                        label: Text('Actions'.toUpperCase()),
                        size: ColumnSize.S,
                        fixedWidth: styles.isMobile ? null : 200),
                  ],
                  rows: managers.map((manager) {
                    var index = managers.indexOf(manager) + 1;
                    return DataRow(cells: [
                      DataCell(Text('$index', style: rowStyles)),
                      //image
                      DataCell(Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: manager.image != null
                              ? NetworkImage(manager.image!)
                              : AssetImage(manager.gender == 'Male'
                                  ? Assets.imagesMale
                                  : Assets.imagesFemale),
                        ),
                      )),
                      DataCell(Text(manager.name, style: rowStyles)),
                      DataCell(Text(manager.gender, style: rowStyles)),
                      DataCell(Text(manager.email, style: rowStyles)),
                      DataCell(Text(manager.phone, style: rowStyles)),
                      DataCell(Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          decoration: BoxDecoration(
                              color: manager.status == 'active'
                                  ? Colors.green
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(manager.status,
                              style: rowStyles.copyWith(color: Colors.white)))),
                               DataCell((){
                                var hostels = ref.watch(hostelsFilterProvider).items.where((element) => element.managerId == manager.id).toList();
                                if(hostels.isEmpty){
                                  return Text('Has No Hostel', style: rowStyles.copyWith(color: Colors.red));
                                }else{
                                  if(hostels.length == 1){
                                    return Text(hostels.first.name, style: rowStyles);
                                  }
                                  return Text('${hostels.length} Hostels', style: rowStyles);
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
                          if (manager.status == 'active')
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
                                                managersFilterProvider.notifier)
                                            .changeStatus(manager, 'blocked');
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
                                            .changeStatus(manager, 'active');
                                      });
                                }),
                        ],
                      )),
                    ]);
                  }).toList()))
        ]));
  }
}
