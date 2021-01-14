import 'package:PamaBacklog/Global/AppRelated/AppColor.dart';
import 'package:PamaBacklog/Screen/Mekanik/AddBacklog/AddBacklog_widgets/MekanikAddBacklogForm1.dart';
import 'package:PamaBacklog/Screen/Mekanik/AddBacklog/AddBacklog_widgets/MekanikAddBacklogForm2.dart';
import 'package:flutter/material.dart';
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
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
