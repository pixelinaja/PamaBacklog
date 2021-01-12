import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:PamaBacklog/Screen/Mekanik/DetailLaporan/DetailLaporan_widgets/MekanikDetailLaporanContentButtons.dart';
import 'package:PamaBacklog/Screen/Mekanik/DetailLaporan/DetailLaporan_widgets/MekanikDetailLaporanContentTextRow.dart';

class MekanikDetailLaporanContentApproved extends StatelessWidget {
  final int rawApprovalGL;
  final String approvalGL;
  final String tanggalEksekusi;
  final String statusPart;
  final String noWr;
  final String statusAction;
  const MekanikDetailLaporanContentApproved({
    Key key,
    this.rawApprovalGL,
    this.approvalGL,
    this.tanggalEksekusi,
    this.statusPart,
    this.noWr,
    this.statusAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Approval GL
          MekanikDetailLaporanContentTextRow(
              leftSide: "Approval GL : $approvalGL"),

          /// Tanggal Eksekusi
          MekanikDetailLaporanContentTextRow(
              leftSide: "Tanggal Eksekusi : $tanggalEksekusi"),

          /// Second Divider
          SizedBox(height: 57.h),
          Divider(color: Colors.black),
          SizedBox(height: 11.h),

          /// Status Part
          MekanikDetailLaporanContentTextRow(
              leftSide: "Status Part : $statusPart"),

          /// No. WR
          MekanikDetailLaporanContentTextRow(leftSide: "No WR : $noWr"),

          /// Padding
          SizedBox(height: 57.h),
        ],
      ),
    );
  }
}
