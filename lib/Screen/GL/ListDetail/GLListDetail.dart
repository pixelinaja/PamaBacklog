import 'package:PamaBacklog/Logic/GL/GLSelectTableOrder/cubit/gl_select_table_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ListDetail_widgets/GLListDetailContent.dart';

class GLListDetail extends StatelessWidget {
  const GLListDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: ThemeData().scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 43.w),
          child: Column(
            children: [
              /// Content
              BlocBuilder<GLSelectTableOrderCubit, GLSelectTableOrderState>(
                builder: (context, state) {
                  if (state is GLSelectTableOrderSelected) {
                    return GLListDetailContent(
                      order: state.tableOrder,
                    );
                  } else {
                    return Container(
                      child: Center(
                        child:
                            Text("No Order Selected, There must be an error."),
                      ),
                    );
                  }
                },
              ),

              /// Padding
              SizedBox(height: 58.h),
            ],
          ),
        ),
      ),
    );
  }
}
