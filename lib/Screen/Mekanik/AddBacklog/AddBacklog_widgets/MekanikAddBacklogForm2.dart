import 'package:PamaBacklog/Logic/Mekanik/AddBacklog/bloc/mekanikadd_bloc.dart';
import 'package:PamaBacklog/Logic/Mekanik/SaveBacklog/cubit/MekanikSaveBacklog_cubit.dart';
import 'package:PamaBacklog/Model/MekanikAddPartNumber.dart';
import 'package:PamaBacklog/Screen/Mekanik/AddBacklog/AddBacklog_widgets/MekanikAddBacklogForm2Text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MekanikAddBacklogForm2 extends StatefulWidget {
  final PageController pageController;
  MekanikAddBacklogForm2({
    Key key,
    this.pageController,
  }) : super(key: key);

  @override
  _MekanikAddBacklogForm2State createState() => _MekanikAddBacklogForm2State();
}

class _MekanikAddBacklogForm2State extends State<MekanikAddBacklogForm2> {
  PageController get pageController => widget.pageController;
  List<TextEditingController> _partNumbers = [];
  List<TextEditingController> _deskripsi = [];
  List<TextEditingController> _qty = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 10; i++) {
      _partNumbers.add(TextEditingController());
      _deskripsi.add(TextEditingController());
      _qty.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().screenHeight - 140.h,
      padding: EdgeInsets.only(top: 28.h),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            children: [
              /// List
              Container(
                height: 470.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: _populateTextfield(),
                  ),
                ),
              ),

              /// Button Section
              SizedBox(height: 64.h),
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => pageController.animateToPage(0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut),
                      child: Container(
                          height: 35.h,
                          width: 35.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: RotatedBox(
                            quarterTurns: 90,
                            child: Icon(
                              Icons.play_arrow,
                              size: 30.w,
                            ),
                          )),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Container(
                          height: 1.h,
                          width: 40.w,
                          color: Colors.black,
                        ),
                        SizedBox(width: 12.w),
                        Container(
                          height: 2.h,
                          width: 40.w,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => _performAddBacklog(),
                      child: Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green.shade700,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30.w,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Perform Add Action
  _performAddBacklog() {
    final state = context.read<MekanikSaveBacklogCubit>().state;
    if (state is MekanikSavedBacklog) {
      if (state.cnUnit.isNotEmpty &&
          state.namaMekanik.isNotEmpty &&
          state.tanggal != null &&
          state.trouble.isNotEmpty) {
        List<MekanikAddPartNumber> partNumbers = [];
        for (var i = 0; i < 10; i++) {
          final partNumber = _partNumbers[i].text.trim();
          final deskripsi = _deskripsi[i].text.trim();
          final qty = _qty[i].text.trim();
          if (partNumber.isNotEmpty && deskripsi.isNotEmpty && qty.isNotEmpty) {
            partNumbers.add(
                MekanikAddPartNumber(partNumber, deskripsi, int.parse(qty)));
          }
        }

        if (partNumbers.length > 0) {
          context.read<MekanikAddBloc>().add(
                MekanikAddStart(
                  cnUnit: state.cnUnit,
                  namaMekanik: state.namaMekanik,
                  tanggalLaporan: state.tanggal,
                  partNumbers: partNumbers,
                  trouble: state.trouble,
                  byPass: false,
                  damageLevel: state.damageLevel,
                  hmUnit: state.hmUnit,
                ),
              );
        } else {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "Tidak Dapat Membuat Laporan, Terdapat Data Part Number yang Tidak Lengkap."),
            ),
          );
        }
      }
    } else {
      print("Else");
    }
  }

  /// Populate 5 Textfield
  List<Widget> _populateTextfield() {
    List<Widget> widgets = [];
    for (var i = 0; i < 10; i++) {
      widgets.addAll([
        MekanikAddBacklogForm2Text(
          deskripsiController: _deskripsi[i],
          index: "${i + 1}.",
          partNumberController: _partNumbers[i],
          qtyController: _qty[i],
        ),
        SizedBox(height: 16.h),
      ]);
    }

    return widgets;
  }

  @override
  void dispose() {
    for (var i = 0; i < 10; i++) {
      _partNumbers[i].dispose();
      _deskripsi[i].dispose();
      _qty[i].dispose();
    }
    super.dispose();
  }
}
