import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MekanikDetailLaporanContentTextRow extends StatelessWidget {
  final String leftSide;
  final String rightSide;
  const MekanikDetailLaporanContentTextRow({
    Key key,
    @required this.leftSide,
    this.rightSide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      child: rightSide != null
          ? Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    leftSide,
                    style: TextStyle(
                        fontSize: 17.ssp, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: rightSide == "CLOSE" || rightSide == "PART KOSONG"
                      ? Container(
                          alignment: Alignment.center,
                          height: 18.h,
                          decoration: BoxDecoration(
                            color: rightSide == "CLOSE"
                                ? AppColor.statusClose
                                : AppColor.statusKosong,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            rightSide,
                            style: TextStyle(
                                fontSize: 12.ssp, color: Colors.white),
                          ),
                        )
                      : Text(
                          rightSide,
                          style: TextStyle(
                              fontSize: 17.ssp, fontWeight: FontWeight.bold),
                        ),
                )
              ],
            )
          : Text(
              leftSide,
              style: TextStyle(fontSize: 17.ssp, fontWeight: FontWeight.bold),
            ),
    );
  }
}
