import 'package:PamaBacklog/Global/AppRelated/AppTextstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GLPerluPersetujuanRow extends StatelessWidget {
  final Orientation orientation;
  const GLPerluPersetujuanRow({Key key, this.orientation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPotrait = orientation == Orientation.portrait;
    return Container(
      height: isPotrait ? 25.h : 50.h,
      margin: EdgeInsets.symmetric(horizontal: 28.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Laporan Perlu Persetujuan",
            style: AppTextstyle.semiBold20,
          ),
        ],
      ),
    );
  }
}
