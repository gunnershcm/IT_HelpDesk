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


class GetAllSolutionEvent extends TicketSolutionEvent {
  final int? idSolution;

  const GetAllSolutionEvent({this.idSolution});
}