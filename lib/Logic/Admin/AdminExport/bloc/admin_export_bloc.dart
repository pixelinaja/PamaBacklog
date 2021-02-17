import 'dart:async';
import 'dart:io';

import 'package:PamaBacklog/Model/TableOrderModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:excel/excel.dart';
import 'package:PamaBacklog/Global/Extension/AppExtensions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'admin_export_event.dart';
part 'admin_export_state.dart';

class AdminExportBloc extends Bloc<AdminExportEvent, AdminExportState> {
  AdminExportBloc() : super(AdminExportInitial());

  @override
  Stream<AdminExportState> mapEventToState(
    AdminExportEvent event,
  ) async* {
    if (event is AdminExportStart) {
      if (await Permission.storage.request().isGranted) {
        yield AdminExportLoading();

        try {
          var excel = Excel.createExcel();

          Sheet sheetObject = excel[
              'Laporan Backlog ${DateTime.now().parseDate(dateFormat: 'dd-MM-yyyy')}'];

          final columnNames = [
            'Doc Id',
            'Tanggal',
            'Status Action',
            'CN Unit',
            'HM Unit',
            'Trouble',
            'Tingkat Kerusakan',
            'Deskripsi',
            'Quantity',
            'Status Part',
            'Part Number',
            'Nama Mekanik',
            'Approval Pengawas',
            'Tanggal Eksekusi',
            'No. WR'
          ];

          /// Loop and create column
          for (var i = 0; i < columnNames.length; i++) {
            sheetObject.updateCell(
                CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0),
                columnNames[i]);
          }

          /// Loop through all table orders and create rows
          for (var i = 0; i < event.tableOrders.length; i++) {
            var data = event.tableOrders[i];
            sheetObject.updateCell(
                CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1),
                data.docId);
            sheetObject.updateCell(
                CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1),
                data.tanggal.toDate().parseDate(dateFormat: "dd/MMMM/yyyy"));
            sheetObject.updateCell(
                CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1),
                data.statusAction);
            sheetObject.updateCell(
                CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1),
                data.cnNumber);
            sheetObject.updateCell(
                CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1),
                data.hmUnit ?? "-");
            sheetObject.updateCell(
                CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1),
                data.trouble);
            sheetObject.updateCell(
                CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1),
                data.damageLevel ?? "-");
            sheetObject.updateCell(
                CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 1),
                data.deskripsi);
            sheetObject.updateCell(
                CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i + 1),
                data.qty);
            sheetObject.updateCell(
                CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i + 1),
                data.statusPart);
            sheetObject.updateCell(
                CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: i + 1),
                data.number);
            sheetObject.updateCell(
                CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i + 1),
                data.namaMekanik);
            sheetObject.updateCell(
                CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: i + 1),
                data.approvalPengawas == 0
                    ? "Belum di-Approve"
                    : data.approvalPengawas == 1
                        ? "Approved"
                        : "Not Approved");
            sheetObject.updateCell(
                CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: i + 1),
                data.tanggalEksekusi == null
                    ? "-"
                    : data.tanggalEksekusi
                        .toDate()
                        .parseDate(dateFormat: "dd/MMMM/yyyy"));
            sheetObject.updateCell(
                CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: i + 1),
                data.noWr);
          }

          final encoded = await excel.encode();
          final iosDirectory = await getExternalStorageDirectory();
          final getDirectory = Platform.isIOS
              ? iosDirectory.path
              : "/storage/emulated/0/Download";
          final export = File("$getDirectory/${sheetObject.sheetName}.xlsx");
          export.createSync(recursive: true);
          export.writeAsBytesSync(encoded);

          yield AdminExportCompleted(
              msg:
                  "File Export Telah Tersimpan di $getDirectory/${sheetObject.sheetName}.xlsx");
        } catch (e) {
          yield AdminExportFailed(error: e.toString());
        }
      } else {
        yield AdminExportFailed(
            error:
                "Anda Belum Mengizinkan Storage Permission Untuk Aplikasi Ini");
      }
    }
  }
}
