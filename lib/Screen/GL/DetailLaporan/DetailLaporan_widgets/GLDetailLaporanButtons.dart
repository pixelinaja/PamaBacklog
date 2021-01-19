import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';

class GLDetailLaporanButtons extends StatelessWidget {
  final VoidCallback notApproveCallback;
  final VoidCallback approveCallback;
  const GLDetailLaporanButtons(
      {Key key,
      @required this.notApproveCallback,
      @required this.approveCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: GestureDetector(
              onTap: notApproveCallback,
              child: Container(
                alignment: Alignment.center,
                height: 48.h,
                decoration: BoxDecoration(
                  color: AppColor.mekanikPartKosongBtnColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Tidak Setujui",
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
          Expanded(
            child: Container(),
            flex: 1,
          ),
          Expanded(
            flex: 8,
            child: GestureDetector(
              onTap: approveCallback,
              child: Container(
                alignment: Alignment.center,
                height: 48.h,
                decoration: BoxDecoration(
                  color: AppColor.mekanikCloseBtnColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Setujui",
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
    );
  }
}
