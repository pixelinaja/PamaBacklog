part of 'admin_add_cn_bloc.dart';

abstract class AdminAddCnState extends Equatable {
  const AdminAddCnState();

  @override
  List<Object> get props => [];
}

class AdminAddCnInitial extends AdminAddCnState {
  final String cnSection;
  final String cnUnit;

  AdminAddCnInitial({this.cnSection, this.cnUnit});

  @override
  List<Object> get props => [cnSection, cnUnit];
}
