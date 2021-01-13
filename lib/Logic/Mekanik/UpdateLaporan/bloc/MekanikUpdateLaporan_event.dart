part of 'MekanikUpdateLaporan_bloc.dart';

abstract class MekanikUpdateLaporanEvent extends Equatable {
  const MekanikUpdateLaporanEvent();

  @override
  List<Object> get props => [];
}

class MekanikUpdateLaporanMulai extends MekanikUpdateLaporanEvent {
  final String docId;
  final String status;
  final String partNumber;
  final TableOrderModel orderDetail;

  MekanikUpdateLaporanMulai(
      {@required this.docId,
      @required this.status,
      @required this.partNumber,
      @required this.orderDetail});
}
