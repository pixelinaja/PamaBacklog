part of 'admin_delete_cn_bloc.dart';

abstract class AdminDeleteCnEvent extends Equatable {
  const AdminDeleteCnEvent();

  @override
  List<Object> get props => [];
}

class AdminDeleteCnStart extends AdminDeleteCnEvent {
  final List<CNModel> cnData;
  final String cnName;
  final String cnNumber;

  AdminDeleteCnStart({this.cnData, this.cnName, this.cnNumber});

  @override
  List<Object> get props => [cnData, cnName, cnNumber];
}
