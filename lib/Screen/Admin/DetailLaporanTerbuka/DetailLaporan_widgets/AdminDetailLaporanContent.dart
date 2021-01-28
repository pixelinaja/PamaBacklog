import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Global/AppRelated/AppString.dart';
import 'package:PamaBacklog/Logic/Admin/AdminSelectOrder/cubit/admin_select_order_cubit.dart';
import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:PamaBacklog/Screen/Mekanik/DetailLaporan/DetailLaporan_widgets/MekanikDetailLaporanContentTextRow.dart';
import 'package:flutter/material.dart';
import 'package:PamaBacklog/Global/Extension/AppExtensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminDetailLaporanContent extends StatelessWidget {
  const AdminDetailLaporanContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminSelectOrderCubit, AdminSelectOrderState>(
        builder: (context, state) {
      final order = (state as AdminSelectOrderSelected).tableOrder;
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Nama Mekanik dan Tanggal
            MekanikDetailLaporanContentTextRow(
              leftSide: order.namaMekanik,
              rightSide:
                  order.tanggal.toDate().parseDate(dateFormat: "dd MMM yyyy"),
            ),

            /// C/N Number dan Part Number
            MekanikDetailLaporanContentTextRow(
                leftSide: order.cnNumber, rightSide: order.number),

            /// QTY
            MekanikDetailLaporanContentTextRow(leftSide: order.qty.toString()),

            /// Trouble
            MekanikDetailLaporanContentTextRow(leftSide: order.trouble),

            /// Deskripsi
            MekanikDetailLaporanContentTextRow(leftSide: order.deskripsi),

            /// First Divider
            SizedBox(height: 21.h),
            Divider(color: Colors.black),
            SizedBox(height: 11.h),

            /// Status Action
            populateStatusAction(order.statusAction.toUpperCase()),

            // Tanggal Eksekusi
            MekanikDetailLaporanContentTextRow(
                leftSide: "Tanggal Eksekusi: " +
                    order.tanggalEksekusi
                        .toDate()
                        .parseDate(dateFormat: "dd MMMM yyyy")),
          ],
        ),
      );
    });
  }

  Widget populateStatusAction(String statusAction) {
    return Container(
      alignment: Alignment.center,
      height: 21.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: generateStatusBGColor(statusAction: statusAction),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        statusAction,
        style: TextStyle(fontSize: 12.ssp, color: Colors.white),
      ),
    );
  }

  /// Generate Color based on Status action
  Color generateStatusBGColor({@required String statusAction}) {
    final status = statusAction.toUpperCase();
    if (status == AppString.PartKosong) {
      return AppColor.statusKosong;
    } else if (status == AppString.Close) {
      return AppColor.statusClose;
    } else if (status == AppString.Approval) {
      return AppColor.statusApproval;
    } else if (status == AppString.NotApprove) {
      return AppColor.statusNotApproved;
    } else {
      return Colors.green.shade700;
    }
  }
}
