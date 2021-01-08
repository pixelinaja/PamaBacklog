import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GLHomeStatistikTotal extends StatelessWidget {
  const GLHomeStatistikTotal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 100.h,
      width: ScreenUtil().screenWidth,
      child: Column(
        children: [
          Text(
            "16",
            style: TextStyle(
              color: AppColor.glHomeNumberColor,
              fontSize: 65.ssp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30.w,
                ),
                Text(
                  "Total Laporan Backlog",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.ssp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black),
                  child: Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
