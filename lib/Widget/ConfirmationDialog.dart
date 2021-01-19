import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmationDialog extends StatelessWidget {
  final String content;
  final String yes;
  final String no;
  final String title;
  final IconData icons;
  final VoidCallback onConfirmTap;
  const ConfirmationDialog({
    Key key,
    @required this.icons,
    @required this.title,
    @required this.content,
    @required this.yes,
    @required this.no,
    this.onConfirmTap,
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
        height: 270.0.h,
        width: 300.0.w,
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 50.h,
                  margin: EdgeInsets.only(top: 50.h),
                  alignment: Alignment.bottomCenter,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 30.ssp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 100.h,
                  padding: EdgeInsets.all(10.w),
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
                  child: Container(
                    width: double.infinity,
                    height: 60.h,
                    margin: EdgeInsets.only(bottom: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 100.w,
                            margin: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.w),
                              color: Colors.red.shade700,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              no,
                              style: TextStyle(
                                fontSize: 16.ssp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: onConfirmTap,
                          child: Container(
                            width: 100.w,
                            margin: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.w),
                              color: Colors.green.shade700,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              yes,
                              style: TextStyle(
                                fontSize: 16.ssp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment(0.0, -1.80),
              child: Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.red.shade700,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icons,
                  color: Colors.white,
                  size: 60.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
