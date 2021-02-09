import 'package:PamaBacklog/Global/Enums/Enums.dart';
import 'package:PamaBacklog/Logic/Firestore/Orders/bloc/orders_bloc.dart';
import 'package:PamaBacklog/Logic/GL/GLApproveOrder/bloc/gl_approve_order_bloc.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:PamaBacklog/Widget/LoadingDialog.dart';
import 'package:PamaBacklog/Widget/SuccessOrFailDialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'DetailLaporan_widgets/GLDetailLaporanContent.dart';
import 'DetailLaporan_widgets/GLDetailLaporanDateField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GLDetailLaporan extends StatelessWidget {
  const GLDetailLaporan({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: ThemeData().scaffoldBackgroundColor,
      ),
      body: BlocListener<GLApproveOrderBloc, GLApproveOrderState>(
        listener: (context, state) {
          /// State is Loading
          if (state is GLApproveOrderLoading) {
            Navigator.of(context).popUntil(
                (route) => route.settings.name == RouteName.glDetailLaporan);
            showDialog(
                context: context,
                barrierDismissible: false,
                child: LoadingDialog());
          }

          /// State is Success
          else if (state is GLApproveOrderSuccess) {
            Navigator.of(context).popUntil(
                (route) => route.settings.name == RouteName.glDetailLaporan);

            /// Backlog is Approved
            if (state.approvalPengawas == 1) {
              showDialog(
                context: context,
                child: SuccessOrFailDialog(
                  dialogStatusType: DialogStatusType.Success,
                  content:
                      "Laporan telah disetujui dan dieksekusi pada tanggal ${state.tanggal}. laporan akan diteruskan kepada Admin untuk segera disiapkan.",
                ),
              );
              context.read<OrdersBloc>().add(OrdersFetch());
            }

            /// Backlog isn't Approved
            else {
              showDialog(
                context: context,
                child: SuccessOrFailDialog(
                  dialogStatusType: DialogStatusType.Success,
                  content:
                      "Laporan pada tanggal ${state.tanggal} dengan CN Number ${state.cnNumber} tidak disetujui, mekanik akan segera memperbaiki backlog.",
                ),
              );
              context.read<OrdersBloc>().add(OrdersFetch());
            }
          }

          /// State is Failed
          else if (state is GLApproveOrderFailed) {
            Navigator.of(context).popUntil(
                (route) => route.settings.name == RouteName.glDetailLaporan);
            showDialog(
              context: context,
              child: SuccessOrFailDialog(
                dialogStatusType: DialogStatusType.Fail,
                content: "${state.error}",
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 43.w),
            child: Column(
              children: [
                /// Content
                GLDetailLaporanContent(),

                /// Padding
                SizedBox(height: 58.h),

                /// Calendar Selector
                GLDetailLaporanDateField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
