import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Logic/Admin/AdminSelectOrder/cubit/admin_select_order_cubit.dart';
import 'package:PamaBacklog/Logic/Admin/AdminSubmitEstimasi/bloc/admin_submit_estimasi_bloc.dart';
import 'package:PamaBacklog/Model/OrderModel.dart';
import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:PamaBacklog/Widget/ConfirmationDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PamaBacklog/Global/Extension/AppExtensions.dart';

class AdminDetailLaporanDateField extends StatefulWidget {
  const AdminDetailLaporanDateField({Key key}) : super(key: key);

  @override
  _AdminDetailLaporanDateFieldState createState() =>
      _AdminDetailLaporanDateFieldState();
}

class _AdminDetailLaporanDateFieldState
    extends State<AdminDetailLaporanDateField> {
  TextEditingController _dateFieldController = TextEditingController();
  DateTime _selectedDate;

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
            controller: _dateFieldController,
            readOnly: true,
            onTap: () async => await _selectDate(context),
            decoration: InputDecoration(
              alignLabelWithHint: true,
              suffixIcon: Icon(Icons.calendar_today),
              hintText: "Pilih Tanggal Estimasi",
              errorText: "*pilih tanggal untuk estimasi part",
            ),
          ),
        ),

        /// Padding
        SizedBox(height: 28.h),

        /// Buttons
        GestureDetector(
          onTap: () => _showConfirmationDialog(order, tableOrder),
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
    showDialog(
      context: context,
      child: ConfirmationDialog(
          icons: Icons.error_outline,
          title: "Peringatan!",
          content:
              "Apakah anda yakin ingin memasukkan tanggal estimasi untuk part ini?",
          yes: "Lanjutkan",
          no: "Batalkan",
          onConfirmTap: () {
            context.read<AdminSubmitEstimasiBloc>().add(
                  AdminSubmitEstimasiStart(
                    order: order,
                    tableOrder: tableOrder,
                    tanggalEstimasi: _selectedDate,
                  ),
                );
          }),
    );
  }

  /// Select Date
  _selectDate(BuildContext context) async {
    DateTime _newSelectedDate = await showDatePicker(
      context: context,
      helpText: "Pilih Tanggal untuk Estimasi Kedatangan Part",
      initialDate: _selectedDate == null ? DateTime.now() : _selectedDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (_newSelectedDate != null) {
      _selectedDate = _newSelectedDate;
      _dateFieldController
        ..text = _selectedDate.parseDate(dateFormat: "dd MMMM yyyy")
        ..selection = TextSelection.fromPosition(
          TextPosition(
              offset: _dateFieldController.text.length,
              affinity: TextAffinity.upstream),
        );
    }
  }
}
