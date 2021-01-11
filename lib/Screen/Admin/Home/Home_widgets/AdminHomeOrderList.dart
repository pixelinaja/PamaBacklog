import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Logic/Firestore/Orders/bloc/orders_bloc.dart';
import 'package:PamaBacklog/Model/OrderModel.dart';
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
      height: 385.h,
      child: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is OrdersFetched) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 45.w),
              child: GroupedListView<Order, String>(
                elements: state.adminLaporan,
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
                      )
                    ],
                  ),
                ),
                itemBuilder: (c, element) {
                  return Container(
                    child: Row(
                      children: [
                        Column(
                          children: [
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
                        Container(
                          height: 65.h,
                          width: 200.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "C/N UNIT",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.ssp,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50.w,
                                  ),
                                  Text(
                                    element.cnNumber,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.ssp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.h),
                              Row(
                                children: [
                                  Text(
                                    "Nama Mekanik",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.ssp,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Text(
                                    element.namaMekanik,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.ssp,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColor.statusApproval,
                                ),
                                width: 80.w,
                                height: 15.h,
                                alignment: Alignment.center,
                                child: Text(
                                  "APPROVAL",
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