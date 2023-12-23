// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dich_vu_it/app/constant/value.dart';
import 'package:dich_vu_it/models/request/request.create.tikcket.model.dart';
import 'package:dich_vu_it/models/request/request.task.model.dart';
import 'package:dich_vu_it/models/response/task.model.dart';
import 'package:dich_vu_it/models/response/ticket.response.model.dart';
import 'package:dich_vu_it/provider/session.provider.dart';
import 'package:dich_vu_it/provider/ticket.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'history.state.dart';
part 'history.event.dart';

class HistoryTaskBloc extends Bloc<HistoryTaskEvent, HistoryTaskState> {
  HistoryTaskBloc() : super(HistoryTaskInitial()) {
    // event handler was added
    on<HistoryTaskEvent>((event, emit) async {
      await handle(emit, event);
    });
  }

  handle(Emitter<HistoryTaskState> emit, HistoryTaskEvent event) async {
    emit(HistoryTaskLoading());
    try {
      if (event is GetAllListTaskInactiveEvent) {
        var listSolution = await TicketProvider.getLitsTaskForTicketInacctive(
            idTicket: event.idTicket);
        emit(GetListTaskInactiveSuccessState(list: listSolution));
      }
    } catch (e) {
      print("Loi: $e");
      emit(HistoryTaskError(error: "Error"));
    }
  }
}
