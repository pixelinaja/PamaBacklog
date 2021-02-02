import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Logic/Admin/AdminSelectOrder/cubit/admin_select_order_cubit.dart';
import 'package:PamaBacklog/Logic/Admin/AdminSubmitWR/bloc/admin_submit_wr_bloc.dart';
import 'package:PamaBacklog/Model/OrderModel.dart';
import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:PamaBacklog/Widget/ConfirmationDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDetailLaporanWRField extends StatefulWidget {
  const AdminDetailLaporanWRField({Key key}) : super(key: key);

  @override
  _AdminDetailLaporanWRFieldState createState() =>
      _AdminDetailLaporanWRFieldState();
}

class _AdminDetailLaporanWRFieldState extends State<AdminDetailLaporanWRField> {
  final TextEditingController _wrNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final order = (context.watch<AdminSelectOrderCubit>().state
            as AdminSelectOrderSelected)
        .order;
    final tableOrder = (context.watch<AdminSelectOrderCubit>().state
            as AdminSelectOrderSelected)
        .tableOrder;
    return Column(
      children: [
        Container(
          width: 235.w,
          child: TextFormField(
            controller: _wrNumberController,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              hintText: "Masukkan WR Number",
              errorText: "*Masukkan WR Number ketika barang ready",
            ),
          ),
        ),

        /// Padding
        SizedBox(height: 28.h),

        /// Buttons
        GestureDetector(
          onTap: () {
            _showConfirmationDialog(order, tableOrder);
          },
          child: Container(
            alignment: Alignment.center,
            height: 48.h,
            width: 130.w,
            decoration: BoxDecoration(
              color: AppColor.mekanikCloseBtnColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Submit",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.ssp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Show Confirmation Dialog
  _showConfirmationDialog(Order order, TableOrderModel tableOrder) {
    if (_wrNumberController.text.trim().isNotEmpty &&
        _wrNumberController.text != null &&
        _wrNumberController.text != "-") {
      showDialog(
        context: context,
        child: ConfirmationDialog(
            icons: Icons.error_outline,
            title: "Peringatan!",
            content:
                "Apakah anda yakin ingin memasukkan WR Number: ${_wrNumberController.text} untuk part ini?",
            yes: "Lanjutkan",
            no: "Batalkan",
            onConfirmTap: () {
              context.read<AdminSubmitWrBloc>().add(
                    AdminSubmitWrStart(
                      order: order,
                      tableOrder: tableOrder,
                      wrNumber: _wrNumberController.text,
                    ),
                  );
            }),
      );
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Mohon Isi WR Number")));
    }
  }
}
