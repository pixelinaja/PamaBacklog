import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Global/AppRelated/AppTextstyle.dart';
import 'package:PamaBacklog/Logic/Admin/AdminSwitchLaporan/cubit/admin_switch_laporan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminLogLaporanRow extends StatelessWidget {
  final Orientation orientation;
  const AdminLogLaporanRow({Key key, this.orientation}) : super(key: key);

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
            "Log Laporan",
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
                    onTap: () => context
                        .read<AdminSwitchLaporanCubit>()
                        .adminSwitchAll(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                          color: (context.watch<AdminSwitchLaporanCubit>().state
                                  is AdminSwitchLaporanOpen)
                              ? null
                              : AppColor.adminColor),
                      alignment: Alignment.center,
                      child: Text(
                        "All",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: (context
                                    .watch<AdminSwitchLaporanCubit>()
                                    .state is AdminSwitchLaporanAll)
                                ? null
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => context
                        .read<AdminSwitchLaporanCubit>()
                        .adminSwitchOpen(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: (context.watch<AdminSwitchLaporanCubit>().state
                                is AdminSwitchLaporanOpen)
                            ? AppColor.adminColor
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Open",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: (context
                                    .watch<AdminSwitchLaporanCubit>()
                                    .state is AdminSwitchLaporanAll)
                                ? Colors.black
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
