import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Logic/Firestore/Orders/bloc/orders_bloc.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminHomeStatistikTotal extends StatelessWidget {
  const AdminHomeStatistikTotal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(RouteName.adminLogLaporan),
      child: Container(
        alignment: Alignment.center,
        height: 100.h,
        width: ScreenUtil().screenWidth,
        child: Column(
          children: [
            BlocBuilder<OrdersBloc, OrdersState>(builder: (context, state) {
              if (state is OrdersFetched) {
                return Text(
                  state.tableOrderAdminLaporan.length.toString(),
                  style: TextStyle(
                    color: AppColor.adminColor,
                    fontSize: 65.ssp,
                    fontWeight: FontWeight.bold,
                  ),
                );
              } else {
                return Text(
                  "?",
                  style: TextStyle(
                    color: AppColor.adminColor,
                    fontSize: 65.ssp,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
            }),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 18.w,
                  ),
                  Text(
                    "Total Laporan Backlog".toUpperCase(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.ssp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                    child: Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
