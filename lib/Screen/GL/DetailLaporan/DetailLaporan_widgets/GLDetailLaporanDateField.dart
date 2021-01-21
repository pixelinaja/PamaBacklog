import 'package:PamaBacklog/Logic/GL/GLApproveOrder/bloc/gl_approve_order_bloc.dart';
import 'package:PamaBacklog/Logic/GL/GLSelectOrder/cubit/gl_select_order_cubit.dart';
import 'package:PamaBacklog/Model/OrderModel.dart';
import 'package:PamaBacklog/Widget/ConfirmationDialog.dart';
import 'package:flutter/material.dart';
import 'package:PamaBacklog/Global/Extension/AppExtensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'GLDetailLaporanButtons.dart';

class GLDetailLaporanDateField extends StatefulWidget {
  const GLDetailLaporanDateField({Key key}) : super(key: key);

  @override
  _GLDetailLaporanDateFieldState createState() =>
      _GLDetailLaporanDateFieldState();
}

class _GLDetailLaporanDateFieldState extends State<GLDetailLaporanDateField> {
  TextEditingController _dateFieldController = TextEditingController();
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    final order =
        (context.watch<GLSelectOrderCubit>().state as GLSelectOrderSelected)
            .order;
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
              hintText: "Pilih Tanggal Eksekusi",
              errorText: "*pilih tanggal untuk eksekusi (approval)",
            ),
          ),
        ),

        /// Padding
        SizedBox(height: 28.h),

        /// Buttons
        GLDetailLaporanButtons(
          approveCallback: () {
            if (_selectedDate != null) {
              return _showConfirmationDialog("1", order);
            } else {
              Scaffold.of(context).removeCurrentSnackBar();
              return Scaffold.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text("Silihkan pilih tanggal eksekusi terlebih dahulu."),
                ),
              );
            }
          },
          notApproveCallback: () {
            if (_selectedDate != null) {
              return _showConfirmationDialog("2", order);
            } else {
              Scaffold.of(context).removeCurrentSnackBar();
              return Scaffold.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text("Silihkan pilih tanggal eksekusi terlebih dahulu."),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  /// Show Confirmation Dialog
  _showConfirmationDialog(String approval, Order order) {
    showDialog(
      context: context,
      child: ConfirmationDialog(
        icons: Icons.error_outline,
        title: "Peringatan!",
        content: approval == "1"
            ? "Apakah anda yakin menyetujui order backlog ini?"
            : "Apakah anda yakin tidak menyetujui order backlog ini?",
        yes: "Lanjutkan",
        no: "Batalkan",
        onConfirmTap: approval == "1"
            ? () => context.read<GLApproveOrderBloc>().add(
                GLApproveOrderApproved(
                    order: order, tanggalEksekusi: _selectedDate))
            : () => context.read<GLApproveOrderBloc>().add(
                GLApproveOrderNotApproved(
                    order: order, tanggalEksekusi: _selectedDate)),
      ),
    );
  }

  /// Select Date
  _selectDate(BuildContext context) async {
    DateTime _newSelectedDate = await showDatePicker(
      context: context,
      helpText: "Pilih Tanggal untuk Eksekusi",
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
