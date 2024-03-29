import 'package:PamaBacklog/Logic/Admin/AdminSelectOrder/cubit/admin_select_order_cubit.dart';
import 'package:PamaBacklog/Logic/Firestore/Orders/bloc/orders_bloc.dart';
import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:PamaBacklog/Global/Extension/AppExtensions.dart';

class AdminHomeOrderList extends StatelessWidget {
  AdminHomeOrderList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 375.h,
      child: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is OrdersFetched) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 45.w),
              child: GroupedListView<TableOrderModel, String>(
                elements: state.tableOrderAdminTerbuka,
                groupBy: (element) => element.tanggal.toDate().year.toString(),
                groupComparator: (value1, value2) => value2.compareTo(value1),
                useStickyGroupSeparators: true,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                itemComparator: (element1, element2) =>
                    element2.tanggal.compareTo(element1.tanggal),
                groupHeaderBuilder: (element) => Container(
                  height: 35.h,
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        element.tanggal.toDate().year.toString(),
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.ssp,
                            fontWeight: FontWeight.bold),
                      ),
                      Divider(
                        color: Colors.black,
                        endIndent: 270.w,
                        height: 12.h,
                      )
                    ],
                  ),
                ),

                /// ListView Item
                itemBuilder: (c, element) {
                  return GestureDetector(
                    onTap: () {
                      final tempOrder = state.adminLaporan
                          .firstWhere((el) => el.docId == element.docId);
                      context
                          .read<AdminSelectOrderCubit>()
                          .selectOrder(order: tempOrder, tableOrder: element);
                      Navigator.of(context)
                          .pushNamed(RouteName.adminDetailLaporanTerbuka);
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              /// Tanggal
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                height: 68.h,
                                width: 63.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.purple,
                                ),
                                child: Text(
                                  element.tanggal
                                      .toDate()
                                      .parseDate(dateFormat: "dd MMM"),
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.ssp,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                width: 50.w,
                                child: Divider(
                                  color: Colors.black,
                                  endIndent: 20.w,
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: 16.w),

                          /// Kotak samping kana (CN Unit dan Nama Mekanik)
                          Container(
                            height: 68.h,
                            width: 200.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Row CN Unit
                                Row(
                                  children: [
                                    Container(
                                      width: 50.w,
                                      child: Text(
                                        element.cnNumber,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.ssp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50.w,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          element.number,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.ssp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6.h),

                                /// Row Nama Mekanik
                                Row(
                                  children: [
                                    Container(
                                      width: 50.w,
                                      child: Text(
                                        element.namaMekanik,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.ssp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50.w,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          element.trouble,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.ssp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                /// Divider Hitam
                                Divider(
                                  color: Colors.black,
                                ),

                                /// Approval Status
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.green.shade700,
                                  ),
                                  width: 80.w,
                                  height: 13.h,
                                  alignment: Alignment.center,
                                  child: Text(
                                    element.statusAction,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11.ssp,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is OrdersFailed) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () =>
                        context.read<OrdersBloc>().add(OrdersFetch()),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Something Strange Happen, Please Refresh by Tapping Button Below",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () =>
                        context.read<OrdersBloc>().add(OrdersFetch()),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
