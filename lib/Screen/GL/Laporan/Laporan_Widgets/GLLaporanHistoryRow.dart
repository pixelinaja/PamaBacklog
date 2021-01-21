import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Global/AppRelated/AppTextstyle.dart';
import 'package:PamaBacklog/Logic/GL/GLSwitchTable/cubit/gl_switch_table_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GLLaporanHistoryRow extends StatelessWidget {
  final Orientation orientation;
  const GLLaporanHistoryRow({Key key, this.orientation}) : super(key: key);

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
            "History Laporan",
            style: AppTextstyle.semiBold20,
          ),
          Container(
            width: 90.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColor.mekanikColor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        context.read<GLSwitchTableCubit>().switchToAll(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                          color: (context.watch<GLSwitchTableCubit>().state
                                  is GLSwitchTableOpen)
                              ? null
                              : AppColor.mekanikColor),
                      alignment: Alignment.center,
                      child: Text(
                        "All",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: (context.watch<GLSwitchTableCubit>().state
                                    is GLSwitchTableOpen)
                                ? null
                                : Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        context.read<GLSwitchTableCubit>().switchToOpen(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: (context.watch<GLSwitchTableCubit>().state
                                is GLSwitchTableOpen)
                            ? AppColor.mekanikColor
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Open",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: (context.watch<GLSwitchTableCubit>().state
                                    is GLSwitchTableOpen)
                                ? Colors.white
                                : null),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
