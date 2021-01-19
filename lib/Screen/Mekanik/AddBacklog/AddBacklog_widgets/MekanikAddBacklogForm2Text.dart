import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MekanikAddBacklogForm2Text extends StatelessWidget {
  final String index;
  final TextEditingController partNumberController;
  final TextEditingController deskripsiController;
  final TextEditingController qtyController;
  MekanikAddBacklogForm2Text({
    Key key,
    this.index,
    this.partNumberController,
    this.deskripsiController,
    this.qtyController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 30.h),
              child: Text(
                "$index",
                style: TextStyle(fontSize: 20.ssp),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Column(
              children: [
                Container(
                  child: TextFormField(
                    controller: partNumberController,
                    decoration: InputDecoration(
                      labelText: "Input Part Number dengan tanda (-)",
                      hintText: "Masukkan Part Number dengan tanda (-)",
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.h),
                  child: TextFormField(
                    controller: deskripsiController,
                    decoration: InputDecoration(
                      labelText: "Deskripsi",
                      hintText: "Masukkan Deskripsi",
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.h),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: qtyController,
                    decoration: InputDecoration(
                      labelText: "Qty",
                      hintText: "Masukkan Quantity",
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
