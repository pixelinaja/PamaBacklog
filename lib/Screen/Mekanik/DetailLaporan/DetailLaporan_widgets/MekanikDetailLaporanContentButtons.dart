import 'package:PamaBacklog/Global/AppRelated/AppString.dart';
import 'package:PamaBacklog/Logic/Mekanik/UpdateLaporan/bloc/MekanikUpdateLaporan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:PamaBacklog/Widget/ConfirmationDialog.dart';

class MekanikDetailLaporanContentButtons extends StatelessWidget {
  final int approvalGL;
  final String statusAction;
  final String docId;
  final String partNumber;
  final TableOrderModel orderDetail;
  const MekanikDetailLaporanContentButtons({
    Key key,
    this.approvalGL,
    this.statusAction,
    this.docId,
    this.partNumber,
    this.orderDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: statusAction == "CLOSE" || statusAction == "PART KOSONG"
          ? false
          : true,
      child: Container(
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: Visibility(
                visible: approvalGL != 2 ? true : false,
                child: GestureDetector(
                  /// Dialog Section
                  onTap: () => showDialog(
                    context: context,
                    child: ConfirmationDialog(
                      title: "Peringatan!",
                      content:
                          "Apakah anda yakin ingin menutup laporan ini sebagai Part Kosong?",
                      yes: "Lanjutkan",
                      no: "Tidak",
                      icons: Icons.warning_outlined,
                      onConfirmTap: () {
                        context.read<MekanikUpdateLaporanBloc>().add(
                              MekanikUpdateLaporanMulai(
                                docId: docId,
                                status: AppString.PartKosong,
                                partNumber: partNumber,
                                orderDetail: orderDetail,
                              ),
                            );
                      },
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: AppColor.mekanikPartKosongBtnColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Part Kosong",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.ssp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(),
              flex: 1,
            ),
            Expanded(
              flex: 8,
              child: GestureDetector(
                /// Dialog Section
                onTap: () => showDialog(
                  context: context,
                  child: ConfirmationDialog(
                    title: "peringatan!",
                    content: "Apakah anda yakin ingin menutup laporan ini?",
                    yes: "Lanjutkan",
                    no: "Tidak",
                    icons: Icons.warning_outlined,
                    onConfirmTap: () {
                      context.read<MekanikUpdateLaporanBloc>().add(
                            MekanikUpdateLaporanMulai(
                              docId: docId,
                              status: AppString.Close,
                              partNumber: partNumber,
                              orderDetail: orderDetail,
                            ),
                          );
                    },
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: AppColor.mekanikCloseBtnColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Tutup Laporan",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.ssp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
