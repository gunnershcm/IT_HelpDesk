// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dich_vu_it/app/constant/value.dart';
import 'package:dich_vu_it/models/request/request.create.ticket.model.dart';
import 'package:dich_vu_it/models/request/request.task.model.dart';
import 'package:dich_vu_it/models/response/task.model.dart';
import 'package:dich_vu_it/models/response/ticket.response.model.dart';
import 'package:dich_vu_it/provider/session.provider.dart';
import 'package:dich_vu_it/provider/ticket.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'home.state.dart';
part 'home.event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    // event handler was added
    on<HomeEvent>((event, emit) async {
      await handle(emit, event);
    });
  }

  handle(Emitter<HomeState> emit, HomeEvent event) async {
    emit(HomeLoading());
    try {
      if (event is GetListTicketAssignEvent) {
        var listTicket = await TicketProvider.getAllListTicketAssign();
        emit(GetListTicketAssignSuccessState(list: listTicket));
      } else if (event is GetAllListTaskActiveEvent) {
        var listTask = await TicketProvider.getLitsTaskForTicketAcctive(
            idTicket: event.idTicket);
        emit(GetListTaskActiveSuccessState(list: listTask));
      } else if (event is CreateTaskCustomer) {
        if (event.requestTaskModel.title == "" ||
            event.requestTaskModel.title == null) {
          emit(HomeError(error: "Title can not be blank"));
        } else if (event.requestTaskModel.ticketId == null) {
          emit(HomeError(error: "Title can not be blank"));
        } else if (event.requestTaskModel.priority == null) {
          emit(HomeError(error: "Priority can not be blank"));
        } else if (event.requestTaskModel.scheduledStartTime == null) {
          emit(HomeError(error: "Scheduled Start Time can  not be blank"));
        } else if (event.requestTaskModel.scheduledEndTime == null) {
          emit(HomeError(error: "Scheduled End Time can not be blank"));
        } else {
          var response =
              await TicketProvider.createTicketTask(event.requestTaskModel);
          if (response) {
            emit(CareatedTaskSuccessState());
          } else {
            emit(HomeError(error: "Error"));
          }
        }
      } else if (event is UpdateTaskTicketEvent) {
        if (event.taskModel.priority == null) {
          emit(HomeError(error: "Priority can not be blank"));
        } else if (event.taskModel.scheduledStartTime == null) {
          emit(HomeError(error: "Scheduled Start Time can not be blank"));
        } else if (event.taskModel.scheduledEndTime == null) {
          emit(HomeError(error: "Scheduled End Time can not be blank"));
        } else if (event.taskModel.title == null) {
          emit(HomeError(error: "Title can not be blank"));
        }else if (event.taskModel.taskStatus == null) {
          emit(HomeError(error: "Task Status can not be blank"));
        } else if (event.taskModel.progress == null) {
          emit(HomeError(error: "Progress can not be blank"));
        }else {
          var response = await TicketProvider.updateTicketTask(event.taskModel);
          if (response) {
            emit(EditTaskSuccessState());
          } else {
            emit(HomeError(error: "Error"));
          }
        }
      } else if (event is ClearDataEvent) {
        emit(HomeInitial());
      } else if (event is UpdateTicketEvent) {
        var response =
            await TicketProvider.updateTicketByTech(event.ticketResponseModel);
        if (response) {
          emit(EditTicketSuccessState());
        } else {
          emit(HomeError(error: "Error"));
        }
      }
    } catch (e) {
      print("Loi: $e");
      emit(HomeError(error: "Error"));
    }
  }
}
