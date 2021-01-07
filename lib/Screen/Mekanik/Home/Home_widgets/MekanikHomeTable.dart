import 'package:PamaBacklog/Logic/Mekanik/Home/MekanikTable/bloc/mekaniktable_bloc.dart';
import 'package:PamaBacklog/Model/OrderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';

class MekanikHomeTable extends StatefulWidget {
  final Orientation orientation;
  const MekanikHomeTable({
    Key key,
    this.orientation,
  }) : super(key: key);

  @override
  _MekanikHomeTableState createState() => _MekanikHomeTableState();
}

class _MekanikHomeTableState extends State<MekanikHomeTable> {
  Orientation get orientation => widget.orientation;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 150.h,
      child: Container(
        width: ScreenUtil().screenWidth * 0.90,
        height: ScreenUtil().screenHeight * 0.80,
        child: BlocBuilder<MekanikTableBloc, MekanikTableState>(
            builder: (context, state) {
          if (state is MekanikTableCompleted) {
            return HorizontalDataTable(
              leftHandSideColumnWidth: 60.w,
              rightHandSideColumnWidth:
                  ((_getTitleWidget().length * 100) - 150).w,
              isFixedHeader: true,
              headerWidgets: _getTitleWidget(),
              leftSideItemBuilder: _generateFirstColumnRow,
              rightSideItemBuilder: _generateRightHandSideColumnRow,
              itemCount: state.orders.length,
              rowSeparatorWidget: const Divider(
                color: Colors.black54,
                height: 1.0,
                thickness: 0.0,
              ),
              leftHandSideColBackgroundColor:
                  ThemeData().scaffoldBackgroundColor,
              rightHandSideColBackgroundColor:
                  ThemeData().scaffoldBackgroundColor,
              enablePullToRefresh: false,
              onRefresh: () {},
            );
          } else if (state is MekanikTableLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MekanikTableFailed) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () => context
                        .read<MekanikTableBloc>()
                        .add(MekanikTableFetchData()),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Something Strange Happen, Please Refresh by Tapping Button Below",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () => context
                        .read<MekanikTableBloc>()
                        .add(MekanikTableFetchData()),
                  )
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  List<Widget> _getTitleWidget() {
    return <Widget>[
      /// 1. Search Title
      _buildTitle(" ", 50.w),

      /// 2. Status Action
      _buildTitle("Status Action", 100.w),

      /// 3. CN Unit
      _buildTitle("C/N Unit", 100.w),

      /// 4. Trouble
      _buildTitle("Trouble", 100.w),

      /// 5. Part Number
      _buildTitle("Part Number", 100.w),

      /// 6. Deskripsi
      _buildTitle("Deskripsi", 100.w),

      /// 7. Qty
      _buildTitle("Qty", 50.w),

      /// 8. Nama Mekanik
      _buildTitle("Nama Mekanik", 100.w),

      /// 9. Tanggal Laporan
      _buildTitle("Tanggal Laporan", 100.w),

      /// 10. Tanggal Eksekusi
      _buildTitle("Tanggal Eksekusi", 100.w),

      /// 11. Status Part
      _buildTitle("Status Part", 100.w),

      /// 12. No. WR
      _buildTitle("No. WR", 100.w),
    ];
  }

  Widget _buildTitle(String label, double width) {
    final bool isPotrait = orientation == Orientation.portrait;
    return Container(
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      width: width,
      height: isPotrait ? 50.h : 100.h,
      alignment: Alignment.center,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    final bool isPotrait = orientation == Orientation.portrait;

    return GestureDetector(
      onTap: () => print(index),
      child: Container(
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.tableSearchBG,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 40.w,
          height: isPotrait ? 40.h : 80.h,
          child: Icon(
            Icons.search_sharp,
            color: Colors.white,
          ),
        ),
        width: 50.w,
        height: isPotrait ? 50.h : 100.h,
        alignment: Alignment.center,
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    final bool isPotrait = orientation == Orientation.portrait;
    final orders =
        (context.watch<MekanikTableBloc>().state as MekanikTableCompleted)
            .orders;
    final Order order = orders[index];
    return Row(
      children: <Widget>[
        /// Status Action
        Container(
          child: Text("${order.partNumber.values.first.statusAction}",
              textAlign: TextAlign.center),
          width: 100.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// CN Unit
        Container(
          child: Text("${order.cnNumber}", textAlign: TextAlign.center),
          width: 100.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// Trouble
        Container(
          child: Text("${order.partNumber.values.first.deskripsi}",
              textAlign: TextAlign.center),
          width: 100.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// Part Number
        Container(
          child: Text("${order.partNumber.values.first.number}",
              textAlign: TextAlign.center),
          width: 100.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// Deskripsi
        Container(
          child: Text("${order.partNumber.values.first.deskripsi}",
              textAlign: TextAlign.center),
          width: 100.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// Qty
        Container(
          child: Text("${order.partNumber.values.first.qty}",
              textAlign: TextAlign.center),
          width: 50.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// Nama Mekanik
        Container(
          child: Text("${order.namaMekanik}", textAlign: TextAlign.center),
          width: 100.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// Tanggal Laporan
        Container(
          child: Text("${order.tanggal.toDate()}", textAlign: TextAlign.center),
          width: 100.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// Tanggal Eksekusi
        Container(
          child: Text("${order.tanggalEksekusi.toDate()}",
              textAlign: TextAlign.center),
          width: 100.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// Status Part
        Container(
          child: Text("${order.partNumber.values.first.statusPart}",
              textAlign: TextAlign.center),
          width: 100.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// No. WR
        Container(
          child: Text("${order.noWr}", textAlign: TextAlign.center),
          width: 100.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
