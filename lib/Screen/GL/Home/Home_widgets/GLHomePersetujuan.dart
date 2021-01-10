import 'package:PamaBacklog/Logic/Firestore/Orders/bloc/orders_bloc.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GLHomePersetujuan extends StatelessWidget {
  const GLHomePersetujuan({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(RouteName.glPerluPersetujuan),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 45.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Perlu Persetujuan",
              style: TextStyle(
                fontSize: 12.ssp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                BlocBuilder<OrdersBloc, OrdersState>(builder: (context, state) {
                  if (state is OrdersFetched) {
                    return Text(
                      state.orderPerluPersetujuan.length.toString(),
                      style: TextStyle(
                        fontSize: 12.ssp,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else {
                    return Text(
                      "?",
                      style: TextStyle(
                        fontSize: 12.ssp,
                        fontWeight: FontWeight.bold,
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
