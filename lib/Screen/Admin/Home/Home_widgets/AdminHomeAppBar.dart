import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Global/AssetsRelated/AssetsConstant.dart';
import 'package:PamaBacklog/Logic/Auth/bloc/auth_bloc.dart';
import 'package:PamaBacklog/Logic/Firestore/Orders/bloc/orders_bloc.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:PamaBacklog/Global/Extension/AppExtensions.dart';

class AdminHomeAppBar extends StatelessWidget {
  const AdminHomeAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColor.adminColor,
        height: 80.h,
        padding: EdgeInsets.fromLTRB(36.w, 14.w, 14.w, 14.w),
        child: Row(
          children: [
            Image.asset(
              Assets.admin_icon,
            ),
            SizedBox(
              width: 8.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Hai, Admin!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.ssp,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      DateTime.now().parseDate(dateFormat: "dd MMM yyyy"),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.ssp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () => _showPopupMenu(context),
              child: Icon(
                Icons.more_vert,
                color: Colors.black,
                size: 40.ssp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build Popup menu and it's functionality
  _showPopupMenu(BuildContext context) {
    return showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(1.0, 90.0.h, 0.0, 0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      items: [
        PopupMenuItem<String>(
            child: _buildMenuItem(title: "Dashboard"), value: '1'),
        PopupMenuItem<String>(
            child: _buildMenuItem(title: "Log Laporan"), value: '2'),
        PopupMenuItem<String>(
            child: _buildMenuItem(title: "Laporan Terbuka"), value: '3'),
        PopupMenuItem<String>(
            child: _buildMenuItem(title: "Data C/N"), value: '4'),
        PopupMenuItem<String>(
            child: _buildMenuItem(title: "Logout"), value: '5'),
      ],
      elevation: 8.0,
    ).then<void>((String itemSelected) {
      if (itemSelected == null) return;

      /// Dashboard Selected
      if (itemSelected == "1") {
        context.read<OrdersBloc>().add(OrdersFetch());
      } else if (itemSelected == "2") {
        Navigator.of(context).pushNamed(RouteName.adminLogLaporan);
      } else if (itemSelected == "3") {
        Navigator.of(context).pushNamed(RouteName.adminLaporanTerbuka);
      } else if (itemSelected == "4") {
        Navigator.of(context).pushNamed(RouteName.adminDataCN);
      } else if (itemSelected == "5") {
        context.read<AuthBloc>().add(AuthLogout());
        Navigator.of(context).pushReplacementNamed(RouteName.loginScreen);
      } else {
        /// Code Here
      }
    });
  }

  /// Build Popup menu item
  _buildMenuItem({String title}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.ssp),
          ),
          Divider(),
        ],
      ),
    );
  }
}
