import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Global/Enums/Enums.dart';
import 'package:PamaBacklog/Logic/Admin/AdminAddCN/bloc/admin_add_cn_bloc.dart';
import 'package:PamaBacklog/Logic/Admin/AdminUpdateCN/bloc/admin_update_cn_bloc.dart';
import 'package:PamaBacklog/Logic/Firestore/CN/bloc/cn_bloc.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:PamaBacklog/Screen/Admin/AddCN/AddCN_widgets/AdminAddCNAppbar.dart';
import 'package:PamaBacklog/Screen/Admin/AddCN/AddCN_widgets/AdminAddCNFormContainer.dart';
import 'package:PamaBacklog/Widget/LoadingDialog.dart';
import 'package:PamaBacklog/Widget/SuccessOrFailDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminAddCN extends StatelessWidget {
  final bool isAdd;
  const AdminAddCN({Key key, this.isAdd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              child: LoadingDialog());
          final cnData = (context.read<CNBloc>().state as CNCompleted).cnData;
          final cnField =
              (context.read<AdminAddCnBloc>().state as AdminAddCnInitial);
          context.read<AdminUpdateCnBloc>().add(
                AdminUpdateCNStart(
                    cnData: cnData,
                    cnNumber: cnField.cnUnit,
                    cnSection: cnField.cnSection),
              );
        },
        backgroundColor: AppColor.adminColor,
        child: Icon(
          isAdd ? Icons.add : Icons.edit,
          color: Colors.black,
          size: 38.ssp,
        ),
      ),
      body: BlocListener<AdminUpdateCnBloc, AdminUpdateCnState>(
        listener: (context, state) {
          if (state is AdminUpdateCnLoading) {
            showDialog(
                context: context,
                barrierDismissible: false,
                child: LoadingDialog());
          } else if (state is AdminUpdateCnCompleted) {
            showDialog(
              context: context,
              child: SuccessOrFailDialog(
                dialogStatusType: DialogStatusType.Success,
                content: state.msg,
              ),
            );
            context.read<CNBloc>().add(CNFetch());
          } else if (state is AdminUpdateCnFailed) {
            showDialog(
              context: context,
              child: SuccessOrFailDialog(
                dialogStatusType: DialogStatusType.Fail,
                content: state.error,
              ),
            );
            context.read<CNBloc>().add(CNFetch());
          }
        },
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Container(
              color: AppColor.adminColor,
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenWidth,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    AdminAddCNAppBar(),
                    SizedBox(height: 8.h),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      child: Text(
                        isAdd
                            ? "Tambah Data C/N Unit Baru"
                            : "Ubah Data C/N Unit",
                        style: TextStyle(
                          fontSize: 20.ssp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    AdminAddCNFormContainer(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
