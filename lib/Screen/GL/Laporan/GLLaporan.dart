import 'package:PamaBacklog/Global/Enums/Enums.dart';
import 'package:PamaBacklog/Logic/Firestore/Orders/bloc/orders_bloc.dart';
import 'package:PamaBacklog/Logic/GL/GLDeleteOrder/bloc/gl_delete_order_bloc.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:PamaBacklog/Screen/GL/Home/Home_widgets/GLHomeAppBar.dart';
import 'package:PamaBacklog/Screen/GL/Laporan/Laporan_Widgets/GLLaporanHistoryRow.dart';
import 'package:PamaBacklog/Widget/LoadingDialog.dart';
import 'package:PamaBacklog/Widget/SuccessOrFailDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Laporan_Widgets/GLLaporanHistoryTable.dart';

class GLLaporan extends StatelessWidget {
  const GLLaporan({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<GlDeleteOrderBloc, GlDeleteOrderState>(
          listener: (context, state) {
            if (state is GlDeleteOrderLoading) {
              Navigator.of(context, rootNavigator: true).pop();
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  child: LoadingDialog());
            } else if (state is GlDeleteOrderSuccess) {
              Navigator.of(context, rootNavigator: true).pop();
              showDialog(
                context: context,
                child: SuccessOrFailDialog(
                  dialogStatusType: DialogStatusType.Success,
                  content: state.msg,
                  onTap: () => Navigator.of(context).popUntil(
                      (route) => route.settings.name == RouteName.glLogLaporan),
                ),
              );
              context.read<OrdersBloc>().add(OrdersFetch());
            } else if (state is GlDeleteOrderFailed) {
              Navigator.of(context, rootNavigator: true).pop();
              showDialog(
                context: context,
                child: SuccessOrFailDialog(
                  dialogStatusType: DialogStatusType.Fail,
                  content: state.error,
                  onTap: () => Navigator.of(context).popUntil(
                      (route) => route.settings.name == RouteName.glLogLaporan),
                ),
              );
            }
          },
          child: OrientationBuilder(
            builder: (context, orientation) {
              return Container(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenHeight,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Visibility(
                        child: GLHomeAppBar(),
                        visible: orientation == Orientation.portrait,
                      ),
                      SizedBox(height: 14.h),
                      GLLaporanHistoryRow(orientation: orientation),
                      SizedBox(height: 10.h),
                      GLLaporanHistoryTable(orientation: orientation),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
