import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/views/custom_input.dart';
import '../../../utils/colors.dart';
import '../../../utils/styles.dart';
import '../../auth/providers/user_provider.dart';
import '../../dashboard/provider/main_provider.dart';
import '../provider/admin_booking_provider.dart';

class AdminBookingPage extends ConsumerStatefulWidget {
  const AdminBookingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminBBookingPageState();
}

class _AdminBBookingPageState extends ConsumerState<AdminBookingPage> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: () {
        return buildBookingList();
      }(),
    );
  }

  Widget buildBookingList() {
    Styles styles = Styles(context);
    var titleStyles = styles.title(
        color: Colors.white,
        fontFamily: 'Raleway',
        desktop: 16,
        mobile: 14,
        tablet: 14);
    var rowStyles = styles.body(desktop: 13, mobile: 12, tablet: 12);
    var user = ref.watch(userProvider);
    var bookingProvider = ref.watch(bookingFilterProvider(user.id)).filter;
    var notifier = ref.read(bookingFilterProvider(user.id).notifier);
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Booking List'.toUpperCase(),
              style: styles.title(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway'),
            ),
            const Spacer(),
            if (styles.largerThanMobile ||
                (styles.isMobile && ref.watch(isBookingProvider)))
              SizedBox(
                width: styles.isMobile ? styles.width * .88 : 550,
                child: CustomTextFields(
                  label: 'Search booking',
                  suffixIcon: styles.isMobile
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            ref.read(isBookingProvider.notifier).state = false;
                            notifier.filterBookings('');
                          },
                        )
                      : null,
                  onChanged: (query) {
                    notifier.filterBookings(query);
                  },
                ),
              ),
            if (styles.isMobile && !ref.watch(isBookingProvider))
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  ref.read(isBookingProvider.notifier).state = true;
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
              'No Booking found',
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
                label: Text('Hostel'.toUpperCase()),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Text('Manager'.toUpperCase()),
                size: ColumnSize.M,
              ),
              DataColumn2(
                label: Text('Student'.toUpperCase()),
                size: ColumnSize.M,
              ),
              DataColumn2(
                label: Text('Period'.toUpperCase()),
                size: ColumnSize.M,
              ),
              DataColumn2(
                label: Text('Status'.toString()),
                size: ColumnSize.M,
                fixedWidth: styles.isMobile ? null : 150,
              ),
              DataColumn2(
                label: Text('Total Cost'.toUpperCase()),
                size: ColumnSize.M,
                fixedWidth: styles.isMobile ? null : 150,
              ),
              DataColumn2(
                label: Text('Stu. Approved'.toUpperCase()),
                size: ColumnSize.L,
                fixedWidth: styles.isMobile ? null : 100,
              ),
              DataColumn2(
                label: Text('Man. Approved'.toUpperCase()),
                size: ColumnSize.L,
                fixedWidth: styles.isMobile ? null : 100,
              ),
              DataColumn2(
                label: Text('Action'.toUpperCase()),
                size: ColumnSize.L,
                fixedWidth: styles.isMobile ? null : 200,
              ),
            ],
            rows: List<DataRow>.generate(bookingProvider.length, (index) {
              var booking = bookingProvider[index];
              return DataRow(
                cells: [
                  DataCell(Text('${index + 1}', style: rowStyles)),
                  DataCell(
                    Text(booking.hostelName ?? '', style: rowStyles),
                  ),
                  DataCell(Text(booking.managerName ?? '', style: rowStyles)),
                  DataCell(Text(
                    booking.studentName ?? '',
                    style: rowStyles,
                  )),
                  DataCell(Text('${booking.startDate} - ${booking.endDate}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: rowStyles)),
                  DataCell(Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        color: booking.status == 'approved'
                            ? Colors.green
                            : booking.status == 'pending'
                                ? Colors.orange
                                : Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(booking.status!,
                        style: styles.body(
                            color: Colors.white,
                            desktop: 14,
                            mobile: 12,
                            tablet: 12)),
                  )),
                  DataCell(Text('GHS${booking.totalCost!.toStringAsFixed(2)}',
                      style: rowStyles)),
                  DataCell(Text(booking.studentSigned ? 'Yes' : 'No',
                      style: rowStyles)),
                  DataCell(Text(booking.managerSigned ? 'Yes' : 'No',
                      style: rowStyles)),
                  DataCell(booking.status!.toLowerCase() == 'pending'
                          ? PopupMenuButton(
                              icon: const Icon(
                                Icons.apps,
                                color: primaryColor,
                              ),
                              itemBuilder: (context) {
                                if (booking.managerId == user.id &&
                                    (booking.managerSigned == false)) {
                                  return [
                                    PopupMenuItem(
                                      child: ListTile(
                                        title: const Text('Approve'),
                                        onTap: () {
                                          notifier.approveBooking(
                                              booking.id, user);
                                        },
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: ListTile(
                                        title: const Text('Reject'),
                                        onTap: () {
                                          notifier.rejectBooking(
                                              booking.id, user);
                                        },
                                      ),
                                    ),
                                  ];
                                } else if (booking.studentId == user.id &&
                                    (booking.studentSigned == false)) {
                                  return [
                                    PopupMenuItem(
                                      child: ListTile(
                                        title: const Text('Approve'),
                                        onTap: () {
                                          notifier.approveBooking(
                                              booking.id, user);
                                        },
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: ListTile(
                                        title: const Text('Reject'),
                                        onTap: () {
                                          notifier.rejectBooking(
                                              booking.id, user);
                                        },
                                      ),
                                    ),
                                  ];
                                }
                                return [];
                              },
                            )
                          : const SizedBox.shrink()
                      //Text('')
                      )
                ],
              );
            }),
          ),
        )
      ],
    );
  }
}
