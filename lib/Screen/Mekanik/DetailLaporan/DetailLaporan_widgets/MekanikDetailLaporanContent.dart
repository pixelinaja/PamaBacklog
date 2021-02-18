import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:PamaBacklog/Screen/Mekanik/DetailLaporan/DetailLaporan_widgets/MekanikDetailLaporanContentTextRow.dart';
import 'package:flutter/material.dart';
import 'package:PamaBacklog/Global/Extension/AppExtensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'MekanikDetailLaporanContentApproved.dart';

class MekanikDetailLaporanContent extends StatelessWidget {
  final TableOrderModel order;
  const MekanikDetailLaporanContent({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

          /// HM Unit dan Tingkat Kerusakan
          MekanikDetailLaporanContentTextRow(
              leftSide: order.hmUnit ?? "-",
              rightSide: order.damageLevel ?? "-"),

          /// QTY
          MekanikDetailLaporanContentTextRow(
              leftSide: order.qty.toString(),
              rightSide: order.statusAction == "CLOSE" ||
                      order.statusAction == "PART KOSONG"
                  ? order.statusAction
                  : ""),

          /// Trouble
          MekanikDetailLaporanContentTextRow(leftSide: order.trouble),

          /// Deskripsi
          MekanikDetailLaporanContentTextRow(leftSide: order.deskripsi),

          /// First Divider
          SizedBox(height: 21.h),
          Divider(color: Colors.black),
          SizedBox(height: 11.h),

          /// Build second content of mekanik detail laporan
          Builder(
            builder: (context) {
              /// Jika belum ada respon atau sudah di approve
              if (order.approvalPengawas != 2) {
                return MekanikDetailLaporanContentApproved(
                    approvalGL: order.approvalPengawas == 0
                        ? "Belum ada respon"
                        : order.approvalPengawas == 1
                            ? "YES"
                            : "NO",
                    tanggalEksekusi: order.tanggalEksekusi != null
                        ? order.tanggalEksekusi
                            .toDate()
                            .parseDate(dateFormat: "dd-MM-yyyy")
                        : "-",
                    noWr: order.noWr != null ? order.noWr : "-",
                    statusPart:
                        order.statusPart != null ? order.statusPart : "-",
                    rawApprovalGL: order.approvalPengawas,
                    statusAction: order.statusAction);
              }

              /// Jika tidak di-Approve
              else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MekanikDetailLaporanContentTextRow(
                        leftSide:
                            "Laporan tidak disetujui, silahkan Mekanik melakukan perbaikan sekarang."),
                    MekanikDetailLaporanContentTextRow(
                        leftSide: "Alasan : ${order.rejectNote}"),
                    SizedBox(height: 57.h),
                  ],
                );
              }
            },
          )
        ],
      ),
    );
  }
}
