import 'package:PamaBacklog/Logic/Mekanik/Home/MekanikTable/bloc/mekaniktable_bloc.dart';
import 'package:PamaBacklog/Logic/Mekanik/Home/MekanikTableSwitch/cubit/listviewswitch_cubit.dart';
import 'package:PamaBacklog/Screen/Mekanik/Home/Home_widgets/MekanikHomeTableChild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MekanikHomeTable extends StatelessWidget {
  final Orientation orientation;
  const MekanikHomeTable({
    Key key,
    this.orientation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 150.h,
      child: Container(
        width: ScreenUtil().screenWidth * 0.90,
        height: ScreenUtil().screenHeight * 0.80,
        child: BlocBuilder<MekanikTableBloc, MekanikTableState>(
            builder: (context, state) {
          if (state is MekanikTableCompleted) {
            if (state.orders.isNotEmpty || state.tableOrder.isNotEmpty) {
              /// Build Table Based on Current Switch
              return BlocBuilder<MekanikTableSwitchCubit,
                  MekanikTableSwitchState>(builder: (context, switchState) {
                if (switchState is MekanikTableSwitchAll) {
                  return MekanikHomeTableChild(
                    orders: state.orders,
                    tableOrders: switchState.tableOrder,
                    orientation: orientation,
                  );
                } else if (switchState is MekanikTableSwitchOpen) {
                  return MekanikHomeTableChild(
                    orders: state.orders,
                    tableOrders: switchState.tableOrder,
                    orientation: orientation,
                  );
                } else {
                  return MekanikHomeTableChild(
                    orders: state.orders,
                    tableOrders: state.tableOrder,
                    orientation: orientation,
                  );
                }
              });
            } else {
              /// Return Empty Orders
              return Center(
                child: Text(
                  "Belum ada Order",
                  style: TextStyle(fontSize: 20.w, fontWeight: FontWeight.w600),
                ),
              );
            }
          } else if (state is MekanikTableLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MekanikTableFailed) {
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
                    onPressed: () => context
                        .read<MekanikTableBloc>()
                        .add(MekanikTableFetchData()),
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
                    onPressed: () => context
                        .read<MekanikTableBloc>()
                        .add(MekanikTableFetchData()),
                  )
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
