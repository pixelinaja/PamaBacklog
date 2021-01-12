import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';

class MekanikDetailLaporanContentButtons extends StatelessWidget {
  final int approvalGL;
  final String statusAction;
  final String docId;
  final String partNumber;
  const MekanikDetailLaporanContentButtons({
    Key key,
    this.approvalGL,
    this.statusAction,
    this.docId,
    this.partNumber,
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
                  onTap: () => showDialog(
                    context: context,
                    child: AlertDialog(
                      content: Text(docId + " " + statusAction),
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
                onTap: () => showDialog(
                  context: context,
                  child: AlertDialog(
                    content: Text(docId + " " + statusAction),
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
