import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GLDetailLaporanRow extends StatelessWidget {
  final String leftSide;
  final String center;
  final String rightSide;
  const GLDetailLaporanRow({
    Key key,
    @required this.leftSide,
    this.center,
    this.rightSide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              leftSide,
              style: TextStyle(fontSize: 17.ssp, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              center,
              style: TextStyle(fontSize: 17.ssp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              rightSide,
              style: TextStyle(fontSize: 17.ssp, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
