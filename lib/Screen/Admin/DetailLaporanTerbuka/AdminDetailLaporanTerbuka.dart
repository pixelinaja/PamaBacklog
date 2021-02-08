import 'package:PamaBacklog/Global/AppRelated/AppString.dart';
import 'package:PamaBacklog/Global/Enums/Enums.dart';
import 'package:PamaBacklog/Logic/Admin/AdminSelectOrder/cubit/admin_select_order_cubit.dart';
import 'package:PamaBacklog/Logic/Admin/AdminSubmitEstimasi/bloc/admin_submit_estimasi_bloc.dart';
import 'package:PamaBacklog/Logic/Admin/AdminSubmitWR/bloc/admin_submit_wr_bloc.dart';
import 'package:PamaBacklog/Logic/Firestore/Orders/bloc/orders_bloc.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:PamaBacklog/Screen/Admin/DetailLaporanTerbuka/DetailLaporan_widgets/AdminDetailLaporanDateField.dart';
import 'package:PamaBacklog/Widget/LoadingDialog.dart';
import 'package:PamaBacklog/Widget/SuccessOrFailDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'DetailLaporan_widgets/AdminDetailLaporanContent.dart';
import 'DetailLaporan_widgets/AdminDetailLaporanWRField.dart';

class AdminDetailLaporanTerbuka extends StatelessWidget {
  const AdminDetailLaporanTerbuka({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: ThemeData().scaffoldBackgroundColor,
      ),
      body: BlocListener<AdminSubmitEstimasiBloc, AdminSubmitEstimasiState>(
        listener: (context, state) {
          /// If State is Loading
          if (state is AdminSubmitEstimasiLoading) {
            Navigator.of(context).popUntil((route) =>
                route.settings.name == RouteName.adminDetailLaporanTerbuka);
            showDialog(
                context: context,
                barrierDismissible: false,
                child: LoadingDialog());
          }

          /// If State is Success
          else if (state is AdminSubmitEstimasiSuccess) {
            Navigator.of(context).popUntil((route) =>
                route.settings.name == RouteName.adminDetailLaporanTerbuka);

            showDialog(
              context: context,
              child: SuccessOrFailDialog(
                dialogStatusType: DialogStatusType.Success,
                content: state.msg,
              ),
            );
            context.read<OrdersBloc>().add(OrdersFetch());
          }

          /// If State is Failed
          else if (state is AdminSubmitEstimasiFailed) {
            Navigator.of(context).popUntil((route) =>
                route.settings.name == RouteName.adminDetailLaporanTerbuka);

            showDialog(
              context: context,
              child: SuccessOrFailDialog(
                dialogStatusType: DialogStatusType.Fail,
                content: state.error,
              ),
            );
          }
        },
        child: BlocListener<AdminSubmitWrBloc, AdminSubmitWrState>(
          listener: (context, state) {
            /// If State is Loading
            if (state is AdminSubmitWrLoading) {
              Navigator.of(context).popUntil((route) =>
                  route.settings.name == RouteName.adminDetailLaporanTerbuka);
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  child: LoadingDialog());
            }

            /// If State is Success
            else if (state is AdminSubmitWrSuccess) {
              Navigator.of(context).popUntil((route) =>
                  route.settings.name == RouteName.adminDetailLaporanTerbuka);

              showDialog(
                context: context,
                child: SuccessOrFailDialog(
                  dialogStatusType: DialogStatusType.Success,
                  content: state.msg,
                ),
              );
              context.read<OrdersBloc>().add(OrdersFetch());
            }

            /// If State is Failed
            else if (state is AdminSubmitWrFailed) {
              Navigator.of(context).popUntil((route) =>
                  route.settings.name == RouteName.adminDetailLaporanTerbuka);

              showDialog(
                context: context,
                child: SuccessOrFailDialog(
                  dialogStatusType: DialogStatusType.Fail,
                  content: state.error,
                ),
              );
            }
          },
          child: BlocBuilder<AdminSelectOrderCubit, AdminSelectOrderState>(
            builder: (context, state) {
              final order = (state as AdminSelectOrderSelected).tableOrder;
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 43.w),
                  child: Column(
                    children: [
                      /// Content
                      AdminDetailLaporanContent(),

                      /// Padding
                      SizedBox(height: 58.h),

                      Builder(
                        builder: (context) {
                          if (order.statusPart.isNotEmpty &&
                              order.statusPart != "-" &&
                              (order.noWr.isEmpty || order.noWr == "-") &&
                              order.statusAction == AppString.Approved) {
                            return AdminDetailLaporanWRField();
                          } else if (order.noWr.isNotEmpty &&
                                  order.noWr != "-" ||
                              order.statusAction != AppString.Approved) {
                            return Container();
                          } else {
                            /// Calendar Selector
                            return AdminDetailLaporanDateField();
                          }
                        },
                      ),
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
}
