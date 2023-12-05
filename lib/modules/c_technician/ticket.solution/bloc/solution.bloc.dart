// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dich_vu_it/app/constant/value.dart';
import 'package:dich_vu_it/models/request/request.create.solution.model.dart';
import 'package:dich_vu_it/models/request/request.create.tikcket.model.dart';
import 'package:dich_vu_it/models/request/request.task.model.dart';
import 'package:dich_vu_it/models/response/task.model.dart';
import 'package:dich_vu_it/models/response/ticket.solution.model.dart';
import 'package:dich_vu_it/models/response/tiket.response.model.dart';
import 'package:dich_vu_it/provider/session.provider.dart';
import 'package:dich_vu_it/provider/ticket.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'solution.state.dart';
part 'solution.event.dart';

class TicketSolutionBloc extends Bloc<TicketSolutionEvent, TicketSolutionState> {
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
        var listSolution = await TicketProvider.getAllListSolution();
        emit(GetListSolutionState(list: listSolution));
      }else if(event is CreateSolutionEvent){
        if (event.requestSolutionModel.title == "") {
          emit(TicketSolutionError(error: "Title not null"));
        } else if (event.requestSolutionModel.categoryId == null) {
          emit(TicketSolutionError(error: "Category not null"));
        } else {
          var checkCreateTiket = await TicketProvider.createSolution(event.requestSolutionModel);
          if (checkCreateTiket == true) {
            emit(CareateSolutionSuccessState());
          } else {
            emit(TicketSolutionError(error: "Error"));
          }          
        }
      }
    } catch (e) {
      print("Loi: $e");
      emit(TicketSolutionError(error: "Error"));
    }
  }
}
