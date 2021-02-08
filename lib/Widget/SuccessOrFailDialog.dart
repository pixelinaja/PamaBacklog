import 'package:PamaBacklog/Global/Enums/Enums.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessOrFailDialog extends StatelessWidget {
  final DialogStatusType dialogStatusType;
  final String content;
  const SuccessOrFailDialog({
    Key key,
    @required this.content,
    @required this.dialogStatusType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 250.0.h,
        width: 300.0.w,
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 30.h,
                  margin: EdgeInsets.only(top: 60.h),
                  alignment: Alignment.center,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      dialogStatusType == DialogStatusType.Success
                          ? "SUCCESS"
                          : "ERROR",
                      style: TextStyle(
                          fontSize: 30.ssp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  width: double.infinity,
                  height: 80.h,
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18.ssp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () => Navigator.of(context).popUntil(
                        (route) => route.settings.name == RouteName.homeScreen),
                    child: Container(
                      width: 120.w,
                      height: 40.h,
                      margin: EdgeInsets.only(top: 14.h),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.w),
                          color: dialogStatusType == DialogStatusType.Success
                              ? Colors.green.shade800
                              : Colors.red.shade800,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Okay",
                          style: TextStyle(
                            fontSize: 16.ssp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment(0.0, -1.70),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: dialogStatusType == DialogStatusType.Success
                        ? Colors.green.shade800
                        : Colors.red.shade800,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    dialogStatusType == DialogStatusType.Success
                        ? Icons.check_circle
                        : Icons.close_rounded,
                    color: Colors.white,
                    size: 60.w,
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
