import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Logic/Mekanik/Home/MekanikTable/bloc/mekaniktable_bloc.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:PamaBacklog/Model/OrderModel.dart';
import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:PamaBacklog/Global/Extension/AppExtensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MekanikHomeTableChild extends StatelessWidget {
  final HDTRefreshController _hdtRefreshController = HDTRefreshController();
  final List<Order> orders;
  final List<TableOrderModel> tableOrders;
  final Orientation orientation;
  MekanikHomeTableChild({
    Key key,
    this.orders,
    this.tableOrders,
    this.orientation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HorizontalDataTable(
      leftHandSideColumnWidth: 60.w,
      rightHandSideColumnWidth: ((_getTitleWidget().length * 100) - 100).w,
      isFixedHeader: true,
      headerWidgets: _getTitleWidget(),
      leftSideItemBuilder: _generateFirstColumnRow,
      rightSideItemBuilder: _generateRightHandSideColumnRow,
      itemCount: tableOrders.length,
      rowSeparatorWidget: const Divider(
        color: Colors.black54,
        height: 1.0,
        thickness: 0.0,
      ),
      leftHandSideColBackgroundColor: ThemeData().scaffoldBackgroundColor,
      rightHandSideColBackgroundColor: ThemeData().scaffoldBackgroundColor,
      enablePullToRefresh: true,
      refreshIndicatorHeight: 60.h,
      onRefresh: () {
        context.read<MekanikTableBloc>().add(MekanikTableFetchData());
        _hdtRefreshController.refreshCompleted();
      },
      refreshIndicator: const WaterDropHeader(),
      htdRefreshController: _hdtRefreshController,
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
      _buildTitle("Status Part", 150.w),

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

    /// Search Button (Detail Button)
    return GestureDetector(
      onTap: () {
        return Navigator.of(context).pushNamed(RouteName.mekanikDetailLaporan,
            arguments: tableOrders[index]);
      },
      child: Container(
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.tableSearchBG,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 35.w,
          height: isPotrait ? 35.h : 75.h,
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
    final orders = tableOrders;
    final TableOrderModel order = orders[index];
    return Row(
      children: <Widget>[
        /// Status Action
        Container(
          child: Container(
            height: isPotrait ? 25.h : 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: generateStatusBGColor(statusAction: order.statusAction),
            ),
            child: Text(
              "${order.statusAction}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: isPotrait ? 12.ssp : null,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          width: 100.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// CN Unit
        Container(
          child: Text(
            "${order.cnNumber}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          width: 100.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// Trouble
        Container(
          child: Text(
            "${order.trouble}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          width: 100.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// Part Number
        Container(
          child: Text(
            "${order.number}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          width: 100.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// Deskripsi
        Container(
          child: Text(
            "${order.deskripsi}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          width: 100.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// Qty
        Container(
          child: Text(
            "${order.qty}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          width: 50.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// Nama Mekanik
        Container(
          child: Text(
            "${order.namaMekanik}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          width: 100.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// Tanggal Laporan
        Container(
          child: Text(
            order.tanggal.toDate().parseDate(dateFormat: "dd-MM-yyyy"),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          width: 100.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// Tanggal Eksekusi
        Container(
          child: Text(
            order.tanggalEksekusi
                    ?.toDate()
                    ?.parseDate(dateFormat: "dd-MM-yyyy") ??
                "-",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          width: 100.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// Status Part
        Container(
          child: Container(
            height: isPotrait ? 25.h : 50.h,
            width: 120.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: generatePartBGColor(statusPart: order.statusPart),
            ),
            padding: EdgeInsets.all(5.ssp),
            child: Text(
              "${order.statusPart}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: isPotrait ? 12.ssp : null,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          width: 150.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),

        /// No. WR
        Container(
          child: Text(
            "${order.noWr}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          width: 100.w,
          height: isPotrait ? 50.h : 100.h,
          alignment: Alignment.center,
        ),
      ],
    );
  }

  /// Generate Color based on Status action
  Color generateStatusBGColor({@required String statusAction}) {
    final status = statusAction.toUpperCase();
    if (status == "PART KOSONG") {
      return AppColor.statusKosong;
    } else if (status == "CLOSE") {
      return AppColor.statusClose;
    } else if (status == "APPROVAL") {
      return AppColor.statusApproval;
    } else {
      return AppColor.statusNotApproved;
    }
  }

  /// Generate Status part color
  Color generatePartBGColor({@required String statusPart}) {
    final status = statusPart.toUpperCase();

    if (status == "READY") {
      return AppColor.partReady;
    } else if (status.contains("EST")) {
      return AppColor.partEstimated;
    } else {
      return AppColor.statusNotApproved;
    }
  }
}
