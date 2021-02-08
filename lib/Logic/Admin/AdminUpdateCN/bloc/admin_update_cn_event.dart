part of 'admin_update_cn_bloc.dart';

abstract class AdminUpdateCnEvent extends Equatable {
  const AdminUpdateCnEvent();

  @override
  List<Object> get props => [];
}

class AdminUpdateCNStart extends AdminUpdateCnEvent {
  final String cnNumber;
  final String cnSection;
  final List<CNModel> cnData;

  AdminUpdateCNStart({this.cnNumber, this.cnSection, this.cnData});

  @override
  List<Object> get props => [cnNumber, cnSection, cnData];
}
