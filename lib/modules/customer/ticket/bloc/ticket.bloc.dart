// ignore_for_file: unused_import, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dich_vu_it/app/constant/value.dart';
import 'package:dich_vu_it/models/request/request.create.tikcket.model.dart';
import 'package:dich_vu_it/models/response/tiket.response.model.dart';
import 'package:dich_vu_it/provider/location.provider.dart';
import 'package:dich_vu_it/provider/session.provider.dart';
import 'package:dich_vu_it/provider/ticket.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'ticket.state.dart';
part 'ticket.event.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketInitial()) {
    // event handler was added
    on<TicketEvent>((event, emit) async {
      await ticket(emit, event);
    });
  }

  ticket(Emitter<TicketState> emit, TicketEvent event) async {
    emit(TicketLoading());
    try {
      if (event is GetAllListTicket) {
        var listTicket = await TicketProvider.getAllListTicket();
        emit(TicketSuccessState(list: listTicket));
      } else if (event is CreateTicketEvent) {
        if (event.request.title == "") {
          emit(TicketError(error: "Title not null"));
        } else if (event.request.serviceId == null) {
          emit(TicketError(error: "Service not null"));
        } else {
          var checkCreateTiket = await TicketProvider.createTicket(event.request);
          if (checkCreateTiket == true) {
            emit(CareateTicketSuccessState());
          } else {
            emit(TicketError(error: "Error"));
          }
          ;
        }
      } else if (event is UpdtaeTicketEvent) {
        // updateTicket
        if (event.request.title == "") {
          emit(TicketError(error: "Title not null"));
        } else if (event.request.serviceId == null) {
          emit(TicketError(error: "Service not null"));
        } else {
          var checkCreateTiket = await TicketProvider.updateTicket(event.request);
          if (checkCreateTiket == true) {
            emit(UpdateTicketSuccessState());
          } else {
            emit(TicketError(error: "Error"));
          }
          ;
        }
      }
    } catch (e) {
      print("Loi: $e");
      emit(TicketError(error: "Error"));
    }
  }
}
