import 'package:PamaBacklog/Global/Enums/Enums.dart';
import 'package:PamaBacklog/Logic/Mekanik/Home/MekanikTable/bloc/mekaniktable_bloc.dart';
import 'package:PamaBacklog/Logic/Mekanik/UpdateLaporan/bloc/MekanikUpdateLaporan_bloc.dart';
import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:PamaBacklog/Screen/Mekanik/DetailLaporan/DetailLaporan_widgets/MekanikDetailLaporanContent.dart';
import 'package:PamaBacklog/Widget/LoadingDialog.dart';
import 'package:PamaBacklog/Widget/SuccessOrFailDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'DetailLaporan_widgets/MekanikDetailLaporanContentButtons.dart';

class MekanikDetailLaporan extends StatelessWidget {
  final TableOrderModel orderDetail;
  const MekanikDetailLaporan({Key key, @required this.orderDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<MekanikUpdateLaporanBloc, MekanikUpdateLaporanState>(
        listener: (context, state) {
          if (state is MekanikUpdateLaporanLoading) {
            Navigator.of(context, rootNavigator: true).pop();
            showDialog(context: context, child: LoadingDialog());
          } else if (state is MekanikUpdateLaporanCompleted) {
            context
                .read<MekanikTableBloc>()
                .add(MekanikTableUpdateData(orderDetail: state.orderDetail));
            Navigator.of(context, rootNavigator: true).pop();
            showDialog(
              context: context,
              barrierDismissible: false,
              child: SuccessOrFailDialog(
                  content: "Data Laporan telah berhasil di-update",
                  dialogStatusType: DialogStatusType.Success),
            );
          } else if (state is MekanikUpdateLaporanFailed) {
            Navigator.of(context, rootNavigator: true).pop();
            showDialog(
              context: context,
              barrierDismissible: false,
              child: SuccessOrFailDialog(
                  content: state.error,
                  dialogStatusType: DialogStatusType.Fail),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: ThemeData().scaffoldBackgroundColor,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 43.w),
              child: Column(
                children: [
                  /// Content
                  MekanikDetailLaporanContent(order: orderDetail),

                  /// Buttons
                  Visibility(
                    visible: orderDetail.approvalPengawas == 0 ? false : true,
                    child: MekanikDetailLaporanContentButtons(
                      approvalGL: orderDetail.approvalPengawas,
                      statusAction: orderDetail.statusAction,
                      docId: orderDetail.docId,
                      partNumber: orderDetail.number,
                      orderDetail: orderDetail,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
