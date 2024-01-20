// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dich_vu_it/app/constant/value.dart';
import 'package:dich_vu_it/models/request/request.create.solution.model.dart';
import 'package:dich_vu_it/models/request/request.create.ticket.model.dart';
import 'package:dich_vu_it/models/request/request.task.model.dart';
import 'package:dich_vu_it/models/response/task.model.dart';
import 'package:dich_vu_it/models/response/ticket.solution.model.dart';
import 'package:dich_vu_it/models/response/ticket.response.model.dart';
import 'package:dich_vu_it/provider/session.provider.dart';
import 'package:dich_vu_it/provider/solution.provider.dart';
import 'package:dich_vu_it/provider/ticket.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'solution.state.dart';
part 'solution.event.dart';

class TicketSolutionBloc
    extends Bloc<TicketSolutionEvent, TicketSolutionState> {
  TicketSolutionBloc() : super(TicketSolutionInitial()) {
    // event handler was added
    on<TicketSolutionEvent>((event, emit) async {
      await handle(emit, event);
    });
  }

  handle(Emitter<TicketSolutionState> emit, TicketSolutionEvent event) async {
    emit(TicketSolutionLoading());
    try {
      if (event is GetAllSolutionEvent) {
        var listSolution = await SolutionProvider.getAllListSolution();
        emit(GetListSolutionState(list: listSolution));
      } else if (event is CreateSolutionEvent) {
        if (event.requestSolutionModel.title == "") {
          emit(TicketSolutionError(error: "Title can not be blank"));
        } else if (event.requestSolutionModel.categoryId == null) {
          emit(TicketSolutionError(error: "Category can not be blank"));
        }else if (event.requestSolutionModel.ownerId == null) {
          emit(TicketSolutionError(error: "Owner can not be blank"));
        }else {
          var checkCreateTiket =
              await SolutionProvider.createSolution(event.requestSolutionModel);
          if (checkCreateTiket == true) {
            emit(CareateSolutionSuccessState());
          } else {
            emit(TicketSolutionError(error: "Error"));
          }
        }
      } else if (event is UpdateSolutionTicketEvent) {
        if (event.solutionModel.title == null) {
          emit(TicketSolutionError(error: "Title can not be blank"));
        } else if (event.solutionModel.reviewDate == null) {
          emit(TicketSolutionError(error: "Review Date can not be blank"));
        } else if (event.solutionModel.expiredDate == null) {
          emit(TicketSolutionError(error: "Expire Date can not be blank"));
        } else if (event.solutionModel.categoryId == null) {
          emit(TicketSolutionError(error: "Category can not be blank"));
        } else if (event.solutionModel.ownerId == null) {
          emit(TicketSolutionError(error: "Owner can not be blank"));
        } else {
          var response =
              await SolutionProvider.updateTicketSolution(event.solutionModel);
          if (response) {
            emit(EditSolutionSuccessState());
          } else {
            emit(TicketSolutionError(error: "Error"));
          }
        }
      } else if (event is FixListEvent) {
        emit(GetListSolutionState(list: [event.ticketSolutionModel]));
      }
    } catch (e) {
      print("Loi: $e");
      emit(TicketSolutionError(error: "Error"));
    }
  }
}
