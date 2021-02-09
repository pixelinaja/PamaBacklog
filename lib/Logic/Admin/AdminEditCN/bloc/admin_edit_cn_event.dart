part of 'admin_edit_cn_bloc.dart';

abstract class AdminEditCnEvent extends Equatable {
  const AdminEditCnEvent();

  @override
  List<Object> get props => [];
}

class AdminEditCnStart extends AdminEditCnEvent {
  final CNModel cnData;
  final String cnName;
  final String cnNumber;
  final String oldCnNumber;

  AdminEditCnStart({this.cnData, this.cnName, this.cnNumber, this.oldCnNumber});

  @override
  List<Object> get props => [cnData, cnName, cnNumber, oldCnNumber];
}
