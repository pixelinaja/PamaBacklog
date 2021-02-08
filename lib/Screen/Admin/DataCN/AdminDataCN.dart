import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Logic/Firestore/CN/bloc/cn_bloc.dart';
import 'package:PamaBacklog/Screen/Admin/DataCN/DataCN_widgets/AdminDataCNListContainer.dart';
import 'package:PamaBacklog/Screen/Admin/Home/Home_widgets/AdminHomeAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'DataCN_widgets/AdminDataCNListview.dart';
import 'DataCN_widgets/AdminDataCNRow.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDataCN extends StatefulWidget {
  const AdminDataCN({Key key}) : super(key: key);

  @override
  _AdminDataCNState createState() => _AdminDataCNState();
}

class _AdminDataCNState extends State<AdminDataCN> {
  @override
  void initState() {
    super.initState();

    /// Refresh the Screen after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      return context.read<CNBloc>().add(CNFetch());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColor.adminColor,
        heroTag: 9,
        child: Icon(Icons.add, size: 38.ssp, color: Colors.black),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Container(
            color: AppColor.adminColor,
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  AdminHomeAppBar(),
                  AdminDataCNListContainer(
                    widgets: [
                      SizedBox(height: 14.h),
                      AdminDataCNRow(orientation: orientation),
                      SizedBox(height: 14.h),
                      AdminDataCNListview(orientation: orientation),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
