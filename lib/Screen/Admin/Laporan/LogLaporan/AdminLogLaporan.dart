import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Global/Enums/Enums.dart';
import 'package:PamaBacklog/Logic/Admin/AdminExport/bloc/admin_export_bloc.dart';
import 'package:PamaBacklog/Logic/Firestore/Orders/bloc/orders_bloc.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:PamaBacklog/Screen/Admin/Home/Home_widgets/AdminHomeAppBar.dart';
import 'package:PamaBacklog/Screen/Admin/Laporan/LogLaporan/LogLaporan_Widgets/AdminLogLaporanRow.dart';
import 'package:PamaBacklog/Screen/Admin/Laporan/LogLaporan/LogLaporan_Widgets/AdminLogLaporanTable.dart';
import 'package:PamaBacklog/Widget/ConfirmationDialog.dart';
import 'package:PamaBacklog/Widget/LoadingDialog.dart';
import 'package:PamaBacklog/Widget/SuccessOrFailDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'LogLaporan_Widgets/AdminLogLaporanTableContainer.dart';

class AdminLogLaporan extends StatelessWidget {
  const AdminLogLaporan({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final tableOrder = (context.read<OrdersBloc>().state as OrdersFetched)
              .tableOrderAdminLaporan;
          showDialog(
            context: context,
            child: ConfirmationDialog(
              content: "Apakah Anda Yakin Ingin Export Data Laporan Ini?",
              icons: Icons.error_outline,
              title: "Peringatan",
              no: "Batalkan",
              yes: "Lanjutkan",
              onConfirmTap: () {
                context
                    .read<AdminExportBloc>()
                    .add(AdminExportStart(tableOrders: tableOrder));
              },
            ),
          );
        },
        backgroundColor: AppColor.adminColor,
        child: RotatedBox(
          quarterTurns: 135,
          child: Icon(
            Icons.exit_to_app_outlined,
            color: Colors.black,
            size: 38.ssp,
          ),
        ),
      ),
      body: BlocListener<AdminExportBloc, AdminExportState>(
        listener: (context, state) {
          if (state is AdminExportLoading) {
            Navigator.of(context, rootNavigator: true).pop();
            showDialog(
                context: context,
                barrierDismissible: false,
                child: LoadingDialog());
          } else if (state is AdminExportCompleted) {
            Navigator.of(context, rootNavigator: true).pop();
            showDialog(
              context: context,
              child: SuccessOrFailDialog(
                dialogStatusType: DialogStatusType.Success,
                content: state.msg,
                onTap: () => Navigator.of(context).popUntil((route) =>
                    route.settings.name == RouteName.adminLogLaporan),
              ),
            );
          } else if (state is AdminExportFailed) {
            Navigator.of(context, rootNavigator: true).pop();
            showDialog(
              context: context,
              child: SuccessOrFailDialog(
                dialogStatusType: DialogStatusType.Fail,
                content: state.error,
                onTap: () => Navigator.of(context).popUntil((route) =>
                    route.settings.name == RouteName.adminLogLaporan),
              ),
            );
          }
        },
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Container(
              color: AppColor.adminColor,
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenWidth,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    AdminHomeAppBar(),
                    AdminLogLaporanTableContainer(
                      widgets: [
                        SizedBox(height: 14.h),
                        AdminLogLaporanRow(orientation: orientation),
                        SizedBox(height: 14.h),
                        AdminLogLaporanTable(orientation: orientation)
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
