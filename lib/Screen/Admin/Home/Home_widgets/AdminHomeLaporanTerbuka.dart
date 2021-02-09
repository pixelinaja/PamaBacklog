import 'package:PamaBacklog/Logic/Firestore/Orders/bloc/orders_bloc.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminHomeLaporanTerbuka extends StatelessWidget {
  const AdminHomeLaporanTerbuka({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(RouteName.adminLaporanTerbuka),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 45.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Laporan Terbuka",
              style: TextStyle(
                fontSize: 14.ssp,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                BlocBuilder<OrdersBloc, OrdersState>(builder: (context, state) {
                  if (state is OrdersFetched) {
                    return Text(
                      state.tableOrderAdminTerbuka.length.toString(),
                      style: TextStyle(
                        fontSize: 14.ssp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    );
                  } else {
                    return Text(
                      "?",
                      style: TextStyle(
                        fontSize: 14.ssp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    );
                  }
                }),
                SizedBox(
                  width: 2.w,
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
            )
          ],
        ),
      ),
    );
  }
}
