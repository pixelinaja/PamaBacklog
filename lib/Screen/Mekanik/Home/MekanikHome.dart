import 'package:PamaBacklog/Logic/Mekanik/Home/MekanikTable/bloc/mekaniktable_bloc.dart';
import 'package:PamaBacklog/Screen/Mekanik/Home/Home_widgets/MekanikHomeBG.dart';
import 'package:PamaBacklog/Screen/Mekanik/Home/Home_widgets/MekanikHomeTable.dart';
import 'package:PamaBacklog/Widget/MekanikFAB.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MekanikHome extends StatefulWidget {
  const MekanikHome({Key key}) : super(key: key);

  @override
  _MekanikHomeState createState() => _MekanikHomeState();
}

class _MekanikHomeState extends State<MekanikHome> {
  @override
  void initState() {
    super.initState();
    context.read<MekanikTableBloc>().add(MekanikTableFetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MekanikFAB(),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Container(
            child: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  MekanikHomeBG(
                    orientation: orientation,
                  ),
                  MekanikHomeTable(
                    orientation: orientation,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
