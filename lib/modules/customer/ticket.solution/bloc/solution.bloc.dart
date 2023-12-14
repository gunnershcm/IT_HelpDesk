// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dich_vu_it/app/constant/value.dart';
import 'package:dich_vu_it/models/request/request.create.tikcket.model.dart';
import 'package:dich_vu_it/models/request/request.task.model.dart';
import 'package:dich_vu_it/models/response/task.model.dart';
import 'package:dich_vu_it/models/response/ticket.solution.model.dart';
import 'package:dich_vu_it/models/response/tiket.response.model.dart';
import 'package:dich_vu_it/provider/session.provider.dart';
import 'package:dich_vu_it/provider/solution.provider.dart';
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
        var listSolution = await SolutionProvider.getAllListSolution();
        emit(GetListSolutionState(list: listSolution));
      }
    } catch (e) {
      print("Loi: $e");
      emit(TicketSolutionError(error: "Error"));
    }
  }
}
