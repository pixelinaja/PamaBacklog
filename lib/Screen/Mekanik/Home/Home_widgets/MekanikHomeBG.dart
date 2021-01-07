import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Global/AssetsRelated/AssetsConstant.dart';
import 'package:PamaBacklog/Logic/Mekanik/Home/MekanikTableSwitch/cubit/listviewswitch_cubit.dart';

class MekanikHomeBG extends StatelessWidget {
  final Orientation orientation;
  const MekanikHomeBG({
    Key key,
    this.orientation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPotrait = orientation == Orientation.portrait;
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            color: AppColor.mekanikColor,
          ),
          Container(
            width: ScreenUtil().screenWidth,
            height: isPotrait
                ? ScreenUtil().screenHeight * 0.85
                : ScreenUtil().screenHeight * 0.80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(70)),
              color: ThemeData().scaffoldBackgroundColor,
            ),
          ),
          Positioned(
            top: isPotrait ? 53.h : 75.h,
            left: isPotrait ? 43.w : 5.w,
            child: SizedBox(
              height: isPotrait ? 100.h : 130.h,
              width: 80.w,
              child: Image.asset(Assets.engineer_icon),
            ),
          ),
          Positioned(
            top: isPotrait ? 95.h : 118.h,
            left: isPotrait ? 120.w : 60.w,
            child: SizedBox(
              child: Text(
                "Hi Mekanik!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: isPotrait ? 20.ssp : 30.ssp,
                ),
              ),
            ),
          ),
          Positioned(
            top: isPotrait ? 122.5.h : 158.5.h,
            left: isPotrait ? 120.w : 60.w,
            child: SizedBox(
              child: Text(
                "History Laporan",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: isPotrait ? 20.ssp : 30.ssp,
                ),
              ),
            ),
          ),
          Positioned(
            top: isPotrait ? 126.h : 165.5.h,
            left: 285.w,
            child: Container(
              width: 90.w,
              height: isPotrait ? 20.h : 35.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColor.mekanikColor),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: BlocBuilder<MekanikTableSwitchCubit,
                        MekanikTableSwitchState>(builder: (context, state) {
                      return GestureDetector(
                        onTap: () => context
                            .read<MekanikTableSwitchCubit>()
                            .switchToAll(),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                topLeft: Radius.circular(30),
                              ),
                              color: (state is MekanikTableSwitchAll)
                                  ? AppColor.mekanikColor
                                  : null),
                          alignment: Alignment.center,
                          child: Text(
                            "All",
                            style: TextStyle(
                              color: (state is MekanikTableSwitchAll)
                                  ? Colors.white
                                  : null,
                              fontWeight: FontWeight.bold,
                              fontSize: isPotrait ? 12.ssp : 20.ssp,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  Expanded(
                    child: BlocBuilder<MekanikTableSwitchCubit,
                        MekanikTableSwitchState>(builder: (context, state) {
                      return GestureDetector(
                        onTap: () => context
                            .read<MekanikTableSwitchCubit>()
                            .switchToOpen(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                            color: (state is MekanikTableSwitchOpen)
                                ? AppColor.mekanikColor
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Open",
                            style: TextStyle(
                              color: (state is MekanikTableSwitchOpen)
                                  ? Colors.white
                                  : null,
                              fontWeight: FontWeight.bold,
                              fontSize: isPotrait ? 12.ssp : 20.ssp,
                            ),
                          ),
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
