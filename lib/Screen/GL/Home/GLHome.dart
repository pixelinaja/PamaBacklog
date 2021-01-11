import 'package:PamaBacklog/Logic/Firestore/Orders/bloc/orders_bloc.dart';
import 'package:PamaBacklog/Screen/GL/Home/Home_widgets/GLHomeAppBar.dart';
import 'package:PamaBacklog/Screen/GL/Home/Home_widgets/GLHomePersetujuan.dart';
import 'package:PamaBacklog/Screen/GL/Home/Home_widgets/GLHomeStatistik.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Home_widgets/GLHomeOrderList.dart';

class GLHome extends StatefulWidget {
  const GLHome({Key key}) : super(key: key);

  @override
  _GLHomeState createState() => _GLHomeState();
}

class _GLHomeState extends State<GLHome> {
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
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GLHomeAppBar(),
                  SizedBox(height: 14.h),
                  GLHomeStatistik(),
                  SizedBox(height: 8.h),
                  GLHomePersetujuan(),
                  SizedBox(height: 14.h),
                  GLHomeOrderList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
