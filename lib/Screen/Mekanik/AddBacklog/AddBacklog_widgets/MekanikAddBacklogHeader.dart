import 'package:PamaBacklog/Global/AssetsRelated/AssetsConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MekanikAddBacklogHeader extends StatelessWidget {
  const MekanikAddBacklogHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      height: 110.h,
      child: Row(
        children: [
          SizedBox(width: 20.w),

          /// Close button
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.shade700,
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 20.w),

          /// Mekanik Icon
          Image.asset(
            Assets.engineer_icon,
            height: 80.h,
          ),
          SizedBox(width: 8.w),

          /// Text Hi Mekanik
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Hi, Mekanik!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.ssp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Laporkan Backlog",
                  style: TextStyle(
                    fontSize: 20.ssp,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
