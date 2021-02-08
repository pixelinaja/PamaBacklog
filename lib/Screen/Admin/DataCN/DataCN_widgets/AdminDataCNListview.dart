import 'package:PamaBacklog/Logic/Firestore/CN/bloc/cn_bloc.dart';
import 'package:PamaBacklog/Router/RouteName.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminDataCNListview extends StatelessWidget {
  final Orientation orientation;
  const AdminDataCNListview({Key key, this.orientation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 28.w),
        child: BlocBuilder<CNBloc, CNState>(builder: (context, state) {
          if (state is CNCompleted) {
            return ListView.builder(
              padding: EdgeInsets.all(0),
              physics: BouncingScrollPhysics(),
              itemCount: state.cnList.length,
              itemBuilder: (BuildContext context, int index) {
                final data = state.cnList[index];
                return ListTile(
                  contentPadding: EdgeInsets.all(0),
                  leading: Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(66, 139, 202, 1),
                    ),
                    child: Center(
                      child: Text(
                        data.cnName.characters.first,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  title: Text(data.cnNumber),
                  subtitle: Text(data.cnName),
                  trailing: Container(
                    height: 40.h,
                    width: 80.w,
                    child: Row(
                      children: [
                        Container(
                          height: 40.h,
                          width: 40.w,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit_outlined,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RouteName.adminEditCN);
                            },
                          ),
                        ),
                        Container(
                          height: 40.h,
                          width: 40.w,
                          child: IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.black,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is CNLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
