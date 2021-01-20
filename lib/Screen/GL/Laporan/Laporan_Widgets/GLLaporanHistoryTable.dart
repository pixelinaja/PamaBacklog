import 'package:PamaBacklog/Global/AssetsRelated/AssetsConstant.dart';
import 'package:PamaBacklog/Logic/Firestore/Orders/bloc/orders_bloc.dart';
import 'package:PamaBacklog/Logic/GL/GLSwitchTable/cubit/gl_switch_table_cubit.dart';
import 'package:PamaBacklog/Screen/GL/Laporan/Laporan_Widgets/GLLaporanHistoryTableChild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GLLaporanHistoryTable extends StatelessWidget {
  final Orientation orientation;
  const GLLaporanHistoryTable({
    Key key,
    this.orientation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth * 0.90,
      height: ScreenUtil().screenHeight * 0.80,
      child: BlocBuilder<OrdersBloc, OrdersState>(builder: (context, state) {
        if (state is OrdersFetched) {
          if (state.orders.isNotEmpty) {
            return BlocBuilder<GLSwitchTableCubit, GLSwitchTableState>(
              builder: (context, switchState) {
                if (switchState is GLSwitchTableAll) {
                  return GLLaporanHistoryTableChild(
                    orders: state.orders,
                    orientation: orientation,
                    tableOrders: state.tableOrder,
                  );
                } else if (switchState is GLSwitchTableOpen) {
                  return GLLaporanHistoryTableChild(
                    orders: state.orderPerluPersetujuan,
                    orientation: orientation,
                    tableOrders: state.tableOrderPerluPersetujuan,
                  );
                } else {
                  return GLLaporanHistoryTableChild(
                    orders: state.orders,
                    orientation: orientation,
                    tableOrders: state.tableOrder,
                  );
                }
              },
            );
          } else {
            /// Return Empty Orders
            return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.no_data,
                      height: 200.h,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Belum ada Order",
                      style: TextStyle(
                          fontSize: 20.ssp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            );
          }
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
        } else if (state is OrdersLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Kesalahan Fatal Terjadi, Mohon Refresh dengan Menekan Tombol Dibawah.",
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
      }),
    );
  }
}
