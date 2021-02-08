part of 'admin_add_cn_bloc.dart';

abstract class AdminAddCnEvent extends Equatable {
  const AdminAddCnEvent();

  @override
  List<Object> get props => [];
}

class AdminAddCnSelectSection extends AdminAddCnEvent {
  final String selectedSection;

  AdminAddCnSelectSection({this.selectedSection});

  @override
  List<Object> get props => [selectedSection];
}

class AdminAddCnInputCN extends AdminAddCnEvent {
  final String cnUnit;

  AdminAddCnInputCN({this.cnUnit});

  @override
  List<Object> get props => [cnUnit];
}
