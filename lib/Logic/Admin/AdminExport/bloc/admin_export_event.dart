part of 'admin_export_bloc.dart';

abstract class AdminExportEvent extends Equatable {
  const AdminExportEvent();

  @override
  List<Object> get props => [];
}

class AdminExportStart extends AdminExportEvent {
  final List<TableOrderModel> tableOrders;

  AdminExportStart({this.tableOrders});

  @override
  List<Object> get props => [tableOrders];
}
