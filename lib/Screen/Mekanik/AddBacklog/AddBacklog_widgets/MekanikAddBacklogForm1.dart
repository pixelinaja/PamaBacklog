import 'package:PamaBacklog/Logic/Mekanik/SaveBacklog/cubit/MekanikSaveBacklog_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:PamaBacklog/Global/Extension/AppExtensions.dart';
import 'package:PamaBacklog/Logic/Firestore/CN/bloc/cn_bloc.dart';
import 'package:PamaBacklog/Model/CNModel.dart';

class MekanikAddBacklogForm1 extends StatefulWidget {
  final PageController pageController;
  MekanikAddBacklogForm1({
    Key key,
    this.pageController,
  }) : super(key: key);

  @override
  _MekanikAddBacklogForm1State createState() => _MekanikAddBacklogForm1State();
}

class _MekanikAddBacklogForm1State extends State<MekanikAddBacklogForm1>
    with AutomaticKeepAliveClientMixin {
  PageController get pageController => widget.pageController;
  DateTime selectedDate;
  String _selectedCN;
  String _selectedSection;
  TextEditingController _tanggalController = TextEditingController();
  TextEditingController _namaMekanikController = TextEditingController();
  TextEditingController _troubleController = TextEditingController();
  TextEditingController _hmUnitController = TextEditingController();
  TextEditingController _damageLevelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CNBloc>().add(CNFetch());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      height: ScreenUtil().screenHeight - 140.h,
      padding: EdgeInsets.only(top: 28.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
        ),
      ),
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 38.w),
          child: Column(
            children: [
              Container(
                child: TextFormField(
                  controller: _tanggalController,
                  onTap: () async => await _selectDate(context),
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Tanggal Laporan",
                    hintText: "Pilih Tanggal",
                    alignLabelWithHint: true,
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.h),
                child: TextFormField(
                  controller: _namaMekanikController,
                  decoration: InputDecoration(
                    labelText: "Nama Mekanik",
                    hintText: "Input Nama Mekanik",
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.h),
                child: BlocBuilder<CNBloc, CNState>(builder: (context, state) {
                  return DropdownButtonFormField(
                    items: (state is CNCompleted)
                        ? state.cnData
                            .map((e) => DropdownMenuItem(
                                  child: Text(e.cnName),
                                  value: e.cnName,
                                ))
                            .toList()
                        : [
                            DropdownMenuItem(
                              child: Text("Memuat, Mohon Tunggu"),
                              value: "",
                            )
                          ],
                    decoration: InputDecoration(
                      hintText: "Pilih Section",
                      labelText: "Section",
                      alignLabelWithHint: true,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedSection = value;
                      });
                    },
                    value: _selectedSection,
                  );
                }),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.h),
                child: BlocBuilder<CNBloc, CNState>(builder: (context, state) {
                  return DropdownButtonFormField(
                    items: ((_selectedSection != null) &&
                            (_selectedSection != "") &&
                            (state is CNCompleted))
                        ? _populateCNUnit(state.cnData.firstWhere(
                            (element) => element.cnName == _selectedSection))
                        : [
                            DropdownMenuItem(
                              child: Text(""),
                            ),
                          ],
                    decoration: InputDecoration(
                      hintText: "Pilih CN Unit",
                      labelText: "CN Unit",
                      alignLabelWithHint: true,
                    ),
                    onChanged: (value) {
                      _selectedCN = value;
                    },
                    value: _selectedCN,
                  );
                }),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.h),
                child: TextFormField(
                  controller: _hmUnitController,
                  decoration: InputDecoration(
                    labelText: "HM Unit",
                    hintText: "Input HM Unit",
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.h),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Trouble",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.h),
                alignment: Alignment.centerLeft,
                child: TextFormField(
                  controller: _troubleController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.h),
                child: TextFormField(
                  controller: _damageLevelController,
                  decoration: InputDecoration(
                    labelText: "Tingkat Kerusakan",
                    hintText: "Input Tingkat Kerusakan",
                    alignLabelWithHint: true,
                  ),
                ),
              ),

              /// Button Section
              SizedBox(height: 30.h),
              Container(
                child: Row(
                  children: [
                    Spacer(),
                    Container(
                      height: 2.h,
                      width: 40.w,
                      color: Colors.black,
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      height: 1.h,
                      width: 40.w,
                      color: Colors.black,
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.read<MekanikSaveBacklogCubit>().savePart1(
                            cnUnit: _selectedCN,
                            namaMekanik: _namaMekanikController.text.trim(),
                            tanggal: selectedDate,
                            trouble: _troubleController.text.trim(),
                            damageLevel: _damageLevelController.text.trim(),
                            hmUnit: _hmUnitController.text.trim());
                        if (_selectedCN != null &&
                            _namaMekanikController.text.trim() != "" &&
                            selectedDate != null &&
                            _troubleController.text.trim() != "" &&
                            _hmUnitController.text.trim() != "" &&
                            _damageLevelController.text.trim() != "") {
                          return pageController.animateToPage(1,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        } else {
                          Scaffold.of(context).removeCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Data Tidak Lengkap, Silahkan isi Kotak yang Kosong"),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 35.h,
                        width: 35.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Icon(
                          Icons.play_arrow,
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

  _selectDate(BuildContext context) async {
    DateTime _newSelectedDate = await showDatePicker(
      context: context,
      helpText: "Pilih Tanggal untuk Laporan Backlog",
      initialDate: selectedDate == null ? DateTime.now() : selectedDate,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (_newSelectedDate != null) {
      selectedDate = _newSelectedDate;
      _tanggalController
        ..text = selectedDate.parseDate(dateFormat: "dd MMMM yyyy")
        ..selection = TextSelection.fromPosition(
          TextPosition(
              offset: _tanggalController.text.length,
              affinity: TextAffinity.upstream),
        );
    }
  }

  List<DropdownMenuItem> _populateCNUnit(CNModel cnData) {
    return cnData.cnNumbers
        .map((e) => DropdownMenuItem(
              child: Text(e),
              value: e,
            ))
        .toList();
  }

  @override
  void dispose() {
    _tanggalController.dispose();
    _namaMekanikController.dispose();
    _troubleController.dispose();
    _hmUnitController.dispose();
    _damageLevelController.dispose();
    super.dispose();
  }

  @override
  // implement wantKeepAlive
  bool get wantKeepAlive => true;
}
