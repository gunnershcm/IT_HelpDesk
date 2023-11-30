// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dich_vu_it/app/constant/value.dart';
import 'package:dich_vu_it/models/response/tiket.response.model.dart';
import 'package:dich_vu_it/provider/session.provider.dart';
import 'package:dich_vu_it/provider/ticket.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'history.customer.state.dart';
part 'history.customer.event.dart';

class HistoryCustomerBloc extends Bloc<HistoryCustomerEvent, HistoryCustomerState> {
  HistoryCustomerBloc() : super(HistoryCustomerInitial()) {
    // event handler was added
    on<HistoryCustomerEvent>((event, emit) async {
      await historyCustomer(emit, event);
    });
  }

  historyCustomer(Emitter<HistoryCustomerState> emit, HistoryCustomerEvent event) async {
    emit(HistoryCustomerLoading());
    try {
      if (event is GetAllListHistoryCustomer) {
        await Future.delayed(const Duration(seconds: 1));
        var listTicket = await TicketProvider.getAllListTicketHistory();
        emit(HistoryCustomerSuccessState(list: listTicket));
      }
    } catch (e) {
      print("Loi: $e");
      emit(HistoryCustomerError(error: "Error"));
    }
  }
}
