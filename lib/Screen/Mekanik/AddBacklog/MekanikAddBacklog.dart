import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Global/Enums/Enums.dart';
import 'package:PamaBacklog/Logic/Mekanik/AddBacklog/bloc/mekanikadd_bloc.dart';
import 'package:PamaBacklog/Model/MekanikAddPartNumber.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:PamaBacklog/Screen/Mekanik/AddBacklog/AddBacklog_widgets/MekanikAddBacklogForm1.dart';
import 'package:PamaBacklog/Screen/Mekanik/AddBacklog/AddBacklog_widgets/MekanikAddBacklogForm2.dart';
import 'package:PamaBacklog/Widget/ConfirmationDialog.dart';
import 'package:PamaBacklog/Widget/LoadingDialog.dart';
import 'package:PamaBacklog/Widget/SuccessOrFailDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'AddBacklog_widgets/MekanikAddBacklogHeader.dart';

class MekanikAddBacklog extends StatefulWidget {
  MekanikAddBacklog({Key key}) : super(key: key);

  @override
  _MekanikAddBacklogState createState() => _MekanikAddBacklogState();
}

class _MekanikAddBacklogState extends State<MekanikAddBacklog> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_pageController.page == 1) {
          _pageController.animateToPage(0,
              duration: Duration(milliseconds: 300), curve: Curves.easeOut);
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: BlocListener<MekanikAddBloc, MekanikAddState>(
            listener: (context, state) {
              if (state is MekanikAddFailed) {
                if (state.code == ErrorCode.Severe) {
                  Navigator.of(context).popUntil((route) =>
                      route.settings.name == RouteName.mekanikAddBacklog);
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(state.error),
                  ));
                } else if (state.code == ErrorCode.ShouldShowDialog) {
                  Navigator.of(context).popUntil((route) =>
                      route.settings.name == RouteName.mekanikAddBacklog);
                  showDialog(
                    context: context,
                    child: ConfirmationDialog(
                      icons: Icons.error_outline,
                      title: "Duplikasi!",
                      content: state.error,
                      yes: "Lanjutkan",
                      no: "Tidak",
                      onConfirmTap: () => context.read<MekanikAddBloc>().add(
                            MekanikAddStart(
                              cnUnit: state.prevOrderData.cnNumber,
                              namaMekanik: state.prevOrderData.namaMekanik,
                              tanggalLaporan:
                                  state.prevOrderData.tanggal.toDate(),
                              partNumbers: state
                                  .prevOrderData.partNumber.entries
                                  .map((value) => MekanikAddPartNumber(
                                      value.value.number,
                                      value.value.deskripsi,
                                      value.value.qty)),
                              trouble: state.prevOrderData.trouble,
                              byPass: true,
                            ),
                          ),
                    ),
                  );
                }
              } else if (state is MekanikAddLoading) {
                showDialog(context: context, child: LoadingDialog());
              } else if (state is MekanikAddCompleted) {
                Navigator.of(context).popUntil((route) =>
                    route.settings.name == RouteName.mekanikAddBacklog);
                showDialog(
                  context: context,
                  child: SuccessOrFailDialog(
                      content: "Order Backlog Telah Berhasil dilaporkan",
                      dialogStatusType: DialogStatusType.Success),
                );
              }
            },
            child: Container(
              height: ScreenUtil().screenHeight,
              color: AppColor.mekanikColor,
              child: Stack(
                children: [
                  /// Header
                  MekanikAddBacklogHeader(),

                  /// Content
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: ScreenUtil().screenHeight - 140.h,
                      child: PageView(
                        controller: _pageController,
                        children: [
                          MekanikAddBacklogForm1(
                            pageController: _pageController,
                          ),
                          MekanikAddBacklogForm2(
                            pageController: _pageController,
                          ),
                        ],
                        pageSnapping: true,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
