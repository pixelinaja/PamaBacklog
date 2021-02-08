import 'package:PamaBacklog/Logic/Admin/AdminAddCN/bloc/admin_add_cn_bloc.dart';
import 'package:PamaBacklog/Logic/Firestore/CN/bloc/cn_bloc.dart';
import 'package:PamaBacklog/Model/CNModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminAddCNFormContainer extends StatefulWidget {
  const AdminAddCNFormContainer({Key key}) : super(key: key);

  @override
  _AdminAddCNFormContainerState createState() =>
      _AdminAddCNFormContainerState();
}

class _AdminAddCNFormContainerState extends State<AdminAddCNFormContainer> {
  String _selectedSection;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 695.h,
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      decoration: BoxDecoration(
        color: ThemeData().scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
        ),
      ),
      child: Form(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.h),
              child: DropdownButtonFormField(
                items: _populateCNUnit(),
                decoration: InputDecoration(
                  hintText: "Pilih Section",
                  labelText: "Pilih Section",
                  alignLabelWithHint: true,
                ),
                onChanged: (value) {
                  _selectedSection = value;
                  context
                      .read<AdminAddCnBloc>()
                      .add(AdminAddCnSelectSection(selectedSection: value));
                },
                value: _selectedSection,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8.h),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Input C/N Unit",
                  hintText: "Input C/N Unit",
                  alignLabelWithHint: true,
                ),
                onChanged: (value) {
                  context
                      .read<AdminAddCnBloc>()
                      .add(AdminAddCnInputCN(cnUnit: value));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem> _populateCNUnit() {
    if (context.watch<CNBloc>().state is CNCompleted) {
      List<CNModel> cnData =
          (context.watch<CNBloc>().state as CNCompleted).cnData;
      return cnData
          .map((e) => DropdownMenuItem(
                child: Text(e.cnName),
                value: e.cnName,
              ))
          .toList();
    } else {
      return [];
    }
  }
}
