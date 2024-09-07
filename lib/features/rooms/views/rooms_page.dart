import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/core/views/custom_dialog.dart';
import 'package:unidwell_finder/features/dashboard/provider/main_provider.dart';
import 'package:unidwell_finder/features/rooms/views/edit_room_page.dart';
import 'package:unidwell_finder/features/rooms/views/new_room_page.dart';

import '../../../core/functions/transparent_page.dart';
import '../../../core/views/custom_button.dart';
import '../../../core/views/custom_input.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../../auth/providers/user_provider.dart';
import '../provider/room_provider.dart';

class RoomsPage extends ConsumerStatefulWidget {
  const RoomsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoomsPageState();
}

class _RoomsPageState extends ConsumerState<RoomsPage> {
  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: () {
        if (user.role == 'admin') {
          return buildAdminList();
        }
        return buildManagerList();
      }(),
    );
  }

  Widget buildAdminList() {
    var roomsFilter = ref.watch(roomsFilterProvider).filteredList;
    var allHostels = ref
        .watch(hostelsFilterProvider)
        .items
        .where((elemet) => elemet.managerId == ref.watch(userProvider).id)
        .map((e) => e.name)
        .toList();
    Styles styles = Styles(context);
    var titleStyles = styles.title(
        color: Colors.white,
        fontFamily: 'Raleway',
        desktop: 16,
        mobile: 14,
        tablet: 14);
    var rowStyles = styles.body(desktop: 13, mobile: 12, tablet: 12);
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Rooms'.toUpperCase(),
              style: styles.title(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway'),
            ),
            const Spacer(),
            if (styles.largerThanMobile ||
                (styles.isMobile &&
                    ref.watch(isSearchingRoomDashboardProvider)))
              SizedBox(
                width: styles.isMobile ? styles.width * .88 : 550,
                child: CustomTextFields(
                  label: 'Search Room',
                  suffixIcon: styles.isMobile
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            ref
                                .read(isSearchingRoomDashboardProvider.notifier)
                                .state = false;
                            ref
                                .read(roomsFilterProvider.notifier)
                                .filterRooms('');
                          },
                        )
                      : null,
                  onChanged: (query) {
                    ref.read(roomsFilterProvider.notifier).filterRooms(query);
                  },
                ),
              ),
            if (styles.isMobile && !ref.watch(isSearchingRoomDashboardProvider))
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  ref.read(isSearchingRoomDashboardProvider.notifier).state =
                      true;
                },
              ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: DataTable2(
            columnSpacing: 20,
            horizontalMargin: 12,
            empty: Center(
                child: Text(
              'No Room found for this hostel',
              style: rowStyles,
            )),
            minWidth: 800,
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
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ref.watch(selectedHostelProvider).isEmpty
                        ? 'Hotel Name'.toUpperCase()
                        : ref.watch(selectedHostelProvider)),
                    const SizedBox(width: 10),
                    PopupMenuButton(
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: '',
                              child: Text('All'),
                            ),
                            for (var hostel in allHostels)
                              PopupMenuItem(
                                value: hostel,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 15, left: 5),
                                  child: Text(
                                    hostel,
                                    maxLines: 1,
                                  ),
                                ),
                              )
                          ];
                        },
                        icon: const Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        ),
                        onSelected: (value) {
                          ref.read(selectedHostelProvider.notifier).state =
                              value;
                          ref
                              .read(roomsFilterProvider.notifier)
                              .filterRoomsByHostel(value);
                        }),
                  ],
                ),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Text('Description'.toUpperCase()),
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
                label: Text('Price'.toUpperCase()),
                size: ColumnSize.S,
              ),
              DataColumn2(
                label: Text('Capacity'.toUpperCase()),
                numeric: true,
                size: ColumnSize.S,
              ),
              DataColumn2(
                label: Text('Ava. Space'.toUpperCase()),
                size: ColumnSize.S,
                numeric: true,
              ),
            ],
            rows: List<DataRow>.generate(roomsFilter.length, (index) {
              var room = roomsFilter[index];
              return DataRow(
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
                            image: NetworkImage(room.images[0]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataCell(Text(room.hostelName, style: rowStyles)),
                  DataCell(Text(room.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: rowStyles)),
                  DataCell(Text(room.managerName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: rowStyles)),
                  DataCell(Text(room.managerPhone, style: rowStyles)),
                  DataCell(Text('GHS ${room.price}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: rowStyles)),
                  DataCell(Text('${room.capacity}', style: rowStyles)),
                  DataCell(Text('${room.availableSpace}', style: rowStyles)),
                ],
              );
            }),
          ),
        )
      ],
    );
  }

  Widget buildManagerList() {
    var roomsFilter = ref.watch(roomsFilterProvider).filteredList;
    var allHostels =
        ref.watch(hostelsFilterProvider).items.map((e) => e.name).toList();
    Styles styles = Styles(context);
    var titleStyles = styles.title(
        color: Colors.white,
        fontFamily: 'Raleway',
        desktop: 16,
        mobile: 14,
        tablet: 14);
    var rowStyles = styles.body(desktop: 13, mobile: 12, tablet: 12);
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Rooms'.toUpperCase(),
              style: styles.title(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway'),
            ),
            const Spacer(),
            if (styles.largerThanMobile ||
                (styles.isMobile &&
                    ref.watch(isSearchingRoomDashboardProvider)))
              SizedBox(
                width: styles.isMobile ? styles.width * .88 : 550,
                child: CustomTextFields(
                  label: 'Search Room',
                  suffixIcon: styles.isMobile
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            ref
                                .read(isSearchingRoomDashboardProvider.notifier)
                                .state = false;
                            ref
                                .read(roomsFilterProvider.notifier)
                                .filterRooms('');
                          },
                        )
                      : null,
                  onChanged: (query) {
                    ref.read(roomsFilterProvider.notifier).filterRooms(query);
                  },
                ),
              ),
            if (styles.isMobile && !ref.watch(isSearchingRoomDashboardProvider))
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  ref.read(isSearchingRoomDashboardProvider.notifier).state =
                      true;
                },
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                color: secondaryColor,
                radius: 10,
                text: styles.isMobile ? '' : 'Add Room',
                icon: const Icon(
                  Icons.add,
                  color: primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).push(TransparentRoute(
                      builder: (BuildContext context) => const NewRoomPage()));
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
              'No Room found for this hostel',
              style: rowStyles,
            )),
            minWidth: 800,
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
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(ref.watch(selectedHostelProvider).isEmpty
                          ? 'Hotel Name'.toUpperCase()
                          : ref.watch(selectedHostelProvider)),
                    ),
                    const SizedBox(width: 10),
                    PopupMenuButton(
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: '',
                              child: Text('All'),
                            ),
                            for (var hostel in allHostels)
                              PopupMenuItem(
                                value: hostel,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 15, left: 5),
                                  child: Text(
                                    hostel,
                                    maxLines: 1,
                                  ),
                                ),
                              )
                          ];
                        },
                        icon: const Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        ),
                        onSelected: (value) {
                          ref.read(selectedHostelProvider.notifier).state =
                              value;
                          ref
                              .read(roomsFilterProvider.notifier)
                              .filterRoomsByHostel(value);
                        }),
                  ],
                ),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Text('Description'.toUpperCase()),
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
                label: Text('Price'.toUpperCase()),
                size: ColumnSize.S,
              ),
              DataColumn2(
                label: Text('Capacity'.toUpperCase()),
                numeric: true,
                size: ColumnSize.S,
              ),
              DataColumn2(
                label: Text('Ava. Space'.toUpperCase()),
                size: ColumnSize.S,
                numeric: true,
              ),
              DataColumn2(
                label: Text('Action'.toUpperCase()),
                size: ColumnSize.L,
              ),
            ],
            rows: List<DataRow>.generate(roomsFilter.length, (index) {
              var room = roomsFilter[index];
              return DataRow(
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
                            image: NetworkImage(room.images[0]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  DataCell(Text(room.hostelName, style: rowStyles)),
                  DataCell(Text(room.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: rowStyles)),
                  DataCell(Text(room.managerName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: rowStyles)),
                  DataCell(Text(room.managerPhone, style: rowStyles)),
                  DataCell(Text('GHS ${room.price}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: rowStyles)),
                  DataCell(Text('${room.capacity}', style: rowStyles)),
                  DataCell(Text('${room.availableSpace}', style: rowStyles)),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.of(context).push(TransparentRoute(
                                builder: (BuildContext context) =>
                                    EditRoom(room: room)));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            CustomDialogs.showDialog(
                                message:
                                    'Are you sure you want to delete this room?',
                                type: DialogType.warning,
                                secondBtnText: 'Delete',
                                onConfirm: () {
                                  ref
                                      .read(roomsFilterProvider.notifier)
                                      .deleteRoom(room, ref);
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        )
      ],
    );
  }
}
