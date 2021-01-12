import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:PamaBacklog/Screen/Mekanik/DetailLaporan/DetailLaporan_widgets/MekanikDetailLaporanContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'DetailLaporan_widgets/MekanikDetailLaporanContentButtons.dart';

class MekanikDetailLaporan extends StatelessWidget {
  final TableOrderModel orderDetail;
  const MekanikDetailLaporan({Key key, @required this.orderDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                MekanikDetailLaporanContentButtons(
                  approvalGL: orderDetail.approvalPengawas,
                  statusAction: orderDetail.statusAction,
                  docId: orderDetail.docId,
                  partNumber: orderDetail.number,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
