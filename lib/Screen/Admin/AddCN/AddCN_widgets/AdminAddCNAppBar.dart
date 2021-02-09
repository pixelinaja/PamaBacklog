import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Global/AssetsRelated/AssetsConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PamaBacklog/Global/Extension/AppExtensions.dart';

class AdminAddCNAppBar extends StatelessWidget {
  const AdminAddCNAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColor.adminColor,
        height: 80.h,
        padding: EdgeInsets.fromLTRB(36.w, 14.w, 14.w, 14.w),
        child: Row(
          children: [
            Image.asset(
              Assets.admin_icon,
            ),
            SizedBox(
              width: 8.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Hai, Admin!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.ssp,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      DateTime.now().parseDate(dateFormat: "dd MMM yyyy"),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.ssp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 38.ssp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
