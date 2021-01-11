import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Logic/Firestore/Orders/bloc/orders_bloc.dart';
import 'package:PamaBacklog/Screen/Admin/Home/Home_widgets/AdminHomeContents.dart';
import 'package:PamaBacklog/Screen/Admin/Home/Home_widgets/AdminHomeLaporanTerbuka.dart';
import 'package:PamaBacklog/Screen/Admin/Home/Home_widgets/AdminHomeOrderList.dart';
import 'package:PamaBacklog/Screen/Admin/Home/Home_widgets/AdminHomeStatistik.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Home_widgets/AdminHomeAppBar.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  void initState() {
    super.initState();

    /// Refresh the Screen after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      return context.read<OrdersBloc>().add(OrdersFetch());
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: Container(
            color: AppColor.adminColor,
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  AdminHomeAppBar(),
                  AdminHomeContents(
                    widgets: [
                      SizedBox(height: 14.h),
                      AdminHomeStatistik(),
                      SizedBox(height: 8.h),
                      AdminHomeLaporanTerbuka(),
                      SizedBox(height: 14.h),
                      AdminHomeOrderList(),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
