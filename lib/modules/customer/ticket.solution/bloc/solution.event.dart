part of 'solution.bloc.dart';

abstract class TicketSolutionEvent extends Equatable {
  const TicketSolutionEvent();

  @override
  List<Object> get props => [];
}

class GetAllListSolution extends TicketSolutionEvent {}

class CreateSolutionEvent extends TicketSolutionEvent {
  final RequestCreateSolutionModel requestSolutionModel;

  const CreateSolutionEvent({required this.requestSolutionModel});

  @override
  List<Object> get props => [requestSolutionModel];
}

class UpdateSolutionTicketEvent extends TicketSolutionEvent {
  final TicketSolutionModel solutionModel;

  const UpdateSolutionTicketEvent({required this.solutionModel});

  @override
  List<Object> get props => [solutionModel];
}

class GetAllSolutionEvent extends TicketSolutionEvent {
  final int? idSolution;
  const GetAllSolutionEvent({this.idSolution});
}

class FixListEvent extends TicketSolutionEvent {
  final TicketSolutionModel ticketSolutionModel;
   const FixListEvent({ required this.ticketSolutionModel});
}
