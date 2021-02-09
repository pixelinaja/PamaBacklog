import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'admin_add_cn_event.dart';
part 'admin_add_cn_state.dart';

class AdminAddCnBloc extends Bloc<AdminAddCnEvent, AdminAddCnState> {
  AdminAddCnBloc()
      : super(AdminAddCnInitial(
          cnSection: "",
          cnUnit: "",
        ));

  @override
  Stream<AdminAddCnState> mapEventToState(
    AdminAddCnEvent event,
  ) async* {
    if (event is AdminAddCnSelectSection) {
      yield AdminAddCnInitial(
          cnSection: event.selectedSection,
          cnUnit: (state as AdminAddCnInitial).cnUnit);
    } else if (event is AdminAddCnInputCN) {
      yield AdminAddCnInitial(
          cnSection: (state as AdminAddCnInitial).cnSection,
          cnUnit: event.cnUnit);
    }
  }
}
