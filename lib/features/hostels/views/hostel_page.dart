import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/core/views/custom_button.dart';
import 'package:unidwell_finder/core/views/custom_dialog.dart';
import 'package:unidwell_finder/features/dashboard/provider/main_provider.dart';
import 'package:unidwell_finder/utils/colors.dart';
import 'package:unidwell_finder/utils/styles.dart';

import '../../../core/functions/transparent_page.dart';
import '../../../core/views/custom_input.dart';
import '../../auth/providers/user_provider.dart';
import '../provider/hostel_provider.dart';
import 'new_hostel.dart';

class HostelPage extends ConsumerStatefulWidget {
  const HostelPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HostelPageState();
}

class _HostelPageState extends ConsumerState<HostelPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: () {
       
          return buildHostelsList();
        
      }(),
    );
  }

  Widget buildHostelsList() {
    Styles styles = Styles(context);
    var titleStyles = styles.title(
        color: Colors.white,
        fontFamily: 'Raleway',
        desktop: 16,
        mobile: 14,
        tablet: 14);
    var rowStyles = styles.body(desktop: 13, mobile: 12, tablet: 12);
    var hostelList = ref.watch(hostelsFilterProvider).filteredList;
    var user = ref.watch(userProvider);
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Hostels'.toUpperCase(),
              style: styles.title(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway'),
            ),
            const Spacer(),
            if (styles.largerThanMobile ||
                (styles.isMobile && ref.watch(isSearchingHostel)))
              SizedBox(
                width: styles.isMobile ? styles.width * .88 : 550,
                child: CustomTextFields(
                  label: 'Search Hostels',
                  suffixIcon: styles.isMobile
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            ref.read(isSearchingHostel.notifier).state = false;
                            ref
                                .read(hostelsFilterProvider.notifier)
                                .filterHostels('');
                          },
                        )
                      : null,
                  onChanged: (query) {
                    ref
                        .read(hostelsFilterProvider.notifier)
                        .filterHostels(query);
                  },
                ),
              ),
            if (styles.isMobile && !ref.watch(isSearchingHostel))
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  ref.read(isSearchingHostel.notifier).state = true;
                },
              ),
            if ((styles.largerThanMobile ||
                    (styles.isMobile && !ref.watch(isSearchingHostel))) &&
                user.role != 'manager')
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  color: secondaryColor,
                  radius: 10,
                  text: styles.isMobile ? '' : 'Add Hostel',
                  icon: const Icon(
                    Icons.add,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(TransparentRoute(
                        builder: (BuildContext context) =>
                            const NewHostel()));
                
                  },
                ),
              )
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: DataTable2(
            columnSpacing: 20,
            horizontalMargin: 12,
            empty: Center(
                child: Text(
              'No Hostel found',
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
                  fixedWidth: styles.largerThanMobile ? 80 : null),
              DataColumn2(
                  label: Text('Image'.toUpperCase()),
                  size: ColumnSize.S,
                  fixedWidth: styles.isMobile ? null : 80),
              DataColumn2(
                  label: Text('Name'.toUpperCase()),
                  size: ColumnSize.L,
                  onSort: (columnIndex, ascending) {
                    hostelList.sort((a, b) {
                      if (ascending) {
                        return a.name.compareTo(b.name);
                      } else {
                        return b.name.compareTo(a.name);
                      }
                    });
                  }),
              DataColumn2(
                label: Text('Description'.toUpperCase()),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Text('Location'.toUpperCase()),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Text('Manager'.toString()),
                size: ColumnSize.M,
                fixedWidth: styles.isMobile ? null : 150,
              ),
              DataColumn2(
                label: Text('Phone'.toUpperCase()),
                size: ColumnSize.M,
                fixedWidth: styles.isMobile ? null : 150,
              ),
              DataColumn2(
                label: Text('Status'.toUpperCase()),
                size: ColumnSize.S,
                fixedWidth: styles.isMobile ? null : 100,
              ),
              DataColumn2(
                label: Text('Action'.toUpperCase()),
                size: ColumnSize.S,
                fixedWidth: styles.isMobile ? null : 200,
              ),
            ],
            rows: List<DataRow>.generate(
              hostelList.length,
              (index) => DataRow(
                cells: [
                  DataCell(Text('${index + 1}', style: rowStyles)),
                  DataCell(
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(hostelList[index].images[0]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataCell(Text(hostelList[index].name, style: rowStyles)),
                  DataCell(Text(hostelList[index].description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: rowStyles)),
                  DataCell(Text(hostelList[index].location,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: rowStyles)),
                  DataCell(
                      Text(hostelList[index].managerName, style: rowStyles)),
                  DataCell(Text(hostelList[index].managerPhone,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: rowStyles)),
                  DataCell(Container(
                      width: 90,
                      // alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                          color: hostelList[index].status == 'opened'
                              ? Colors.green
                              : Colors.red,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(hostelList[index].status,
                          style: rowStyles.copyWith(color: Colors.white)))),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: () {},
                        ),
                        if (user.id == hostelList[index].managerId)
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {},
                          ),
                        if (user.id == hostelList[index].managerId)
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {},
                          ),
                        if (user.role == 'admin')
                          if (hostelList[index].status == 'opened')
                            IconButton(
                              icon: const Icon(
                                Icons.block,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                CustomDialogs.showDialog(
                                  message:
                                      'Are you sure you want to block this hostel?',
                                  secondBtnText: 'Block',
                                  type: DialogType.warning,
                                  onConfirm: () {
                                    ref
                                        .read(hostelsFilterProvider.notifier)
                                        .changeHostelState(
                                            hostelList[index], 'closed');
                                  },
                                );
                              },
                            )
                          else if (hostelList[index].status == 'closed')
                            IconButton(
                                onPressed: () {
                                  CustomDialogs.showDialog(
                                    message:
                                        'Are you sure you want to unblock this hostel?',
                                    secondBtnText: 'Unblock',
                                    type: DialogType.warning,
                                    onConfirm: () {
                                      ref
                                          .read(hostelsFilterProvider.notifier)
                                          .changeHostelState(
                                              hostelList[index], 'opened');
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  }
