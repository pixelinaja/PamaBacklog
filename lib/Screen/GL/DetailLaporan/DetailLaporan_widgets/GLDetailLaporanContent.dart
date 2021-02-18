import 'package:PamaBacklog/Logic/GL/GLSelectOrder/cubit/gl_select_order_cubit.dart';
import 'package:PamaBacklog/Model/OrderModel.dart';
import 'package:PamaBacklog/Screen/Mekanik/DetailLaporan/DetailLaporan_widgets/MekanikDetailLaporanContentTextRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PamaBacklog/Global/Extension/AppExtensions.dart';

import 'GLDetailLaporanRow.dart';

class GLDetailLaporanContent extends StatelessWidget {
  const GLDetailLaporanContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GLSelectOrderCubit, GLSelectOrderState>(
        builder: (context, state) {
      final order = (state as GLSelectOrderSelected).order;
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Nama Mekanik dan Tanggal
            MekanikDetailLaporanContentTextRow(
              leftSide: order.namaMekanik,
              rightSide:
                  order.tanggal.toDate().parseDate(dateFormat: "dd MMM yyyy"),
            ),

            /// C/N Number dan Part Number
            MekanikDetailLaporanContentTextRow(leftSide: order.cnNumber),

            /// HM Unit dan Tingkat Kerusakan
            MekanikDetailLaporanContentTextRow(
                leftSide: order.hmUnit ?? "-",
                rightSide: order.damageLevel ?? "-"),

            /// Padding
            SizedBox(height: 20.h),

            /// Part Number, QTY, Desc
            GLDetailLaporanRow(
              leftSide: "Part Number",
              center: "QTY",
              rightSide: "Desc",
            ),
            Column(
              children: _populatePartNumbersDetail(order: order),
            ),

            /// Padding
            SizedBox(height: 20.h),

            /// Trouble
            MekanikDetailLaporanContentTextRow(leftSide: order.trouble),
          ],
        ),
      );
    });
  }

  List<Widget> _populatePartNumbersDetail({Order order}) {
    return order.partNumber.values.map((e) {
      return GLDetailLaporanRow(
        leftSide: e.number,
        center: e.qty.toString(),
        rightSide: e.deskripsi,
      );
    }).toList();
  }
}
