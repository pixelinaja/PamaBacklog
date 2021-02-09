import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Global/Enums/Enums.dart';
import 'package:PamaBacklog/Logic/Admin/AdminAddCN/bloc/admin_add_cn_bloc.dart';
import 'package:PamaBacklog/Logic/Admin/AdminEditCN/bloc/admin_edit_cn_bloc.dart';
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

class AdminAddCN extends StatefulWidget {
  final bool isAdd;
  const AdminAddCN({Key key, this.isAdd}) : super(key: key);

  @override
  _AdminAddCNState createState() => _AdminAddCNState();
}

class _AdminAddCNState extends State<AdminAddCN> {
  String _oldCnNumber;

  @override
  void initState() {
    super.initState();
    _oldCnNumber =
        (context.read<AdminAddCnBloc>().state as AdminAddCnInitial).cnUnit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.isAdd ? addCN(context) : editCN(context);
        },
        backgroundColor: AppColor.adminColor,
        child: Icon(
          widget.isAdd ? Icons.add : Icons.edit,
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
            Navigator.of(context, rootNavigator: true).pop();
            showDialog(
              context: context,
              child: SuccessOrFailDialog(
                dialogStatusType: DialogStatusType.Success,
                content: state.msg,
                onTap: () => Navigator.of(context).popUntil(
                    (route) => route.settings.name == RouteName.adminDataCN),
              ),
            );
            context.read<CNBloc>().add(CNFetch());
          } else if (state is AdminUpdateCnFailed) {
            Navigator.of(context, rootNavigator: true).pop();
            showDialog(
              context: context,
              child: SuccessOrFailDialog(
                dialogStatusType: DialogStatusType.Fail,
                content: state.error,
                onTap: () => Navigator.of(context).popUntil(
                    (route) => route.settings.name == RouteName.adminDataCN),
              ),
            );
            context.read<CNBloc>().add(CNFetch());
          }
        },
        child: BlocListener<AdminEditCnBloc, AdminEditCnState>(
          listener: (context, state) {
            if (state is AdminEditCnLoading) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  child: LoadingDialog());
            } else if (state is AdminEditCnCompleted) {
              Navigator.of(context, rootNavigator: true).pop();
              showDialog(
                context: context,
                child: SuccessOrFailDialog(
                  dialogStatusType: DialogStatusType.Success,
                  content: state.msg,
                  onTap: () => Navigator.of(context).popUntil(
                      (route) => route.settings.name == RouteName.adminDataCN),
                ),
              );
              context.read<CNBloc>().add(CNFetch());
            } else if (state is AdminEditCnFailed) {
              Navigator.of(context, rootNavigator: true).pop();
              showDialog(
                context: context,
                child: SuccessOrFailDialog(
                  dialogStatusType: DialogStatusType.Fail,
                  content: state.error,
                  onTap: () => Navigator.of(context).popUntil(
                      (route) => route.settings.name == RouteName.adminDataCN),
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
                          widget.isAdd
                              ? "Tambah Data C/N Unit Baru"
                              : "Ubah Data C/N Unit",
                          style: TextStyle(
                            fontSize: 20.ssp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      AdminAddCNFormContainer(isAdd: widget.isAdd),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Add CN Function
  void addCN(BuildContext context) {
    showDialog(
        context: context, barrierDismissible: false, child: LoadingDialog());
    final cnData = (context.read<CNBloc>().state as CNCompleted).cnData;
    final cnField = (context.read<AdminAddCnBloc>().state as AdminAddCnInitial);
    context.read<AdminUpdateCnBloc>().add(
          AdminUpdateCNStart(
            cnData: cnData,
            cnNumber: cnField.cnUnit,
            cnSection: cnField.cnSection,
          ),
        );
  }

  /// Edit CN Function
  void editCN(BuildContext context) {
    showDialog(
        context: context, barrierDismissible: false, child: LoadingDialog());
    final cnField = (context.read<AdminAddCnBloc>().state as AdminAddCnInitial);
    final cnData = (context.read<CNBloc>().state as CNCompleted)
        .cnData
        .firstWhere((element) =>
            element.cnName.toLowerCase() == cnField.cnSection.toLowerCase());

    context.read<AdminEditCnBloc>().add(
          AdminEditCnStart(
            cnData: cnData,
            cnNumber: cnField.cnUnit,
            cnName: cnField.cnSection,
            oldCnNumber: this._oldCnNumber,
          ),
        );
  }
}
