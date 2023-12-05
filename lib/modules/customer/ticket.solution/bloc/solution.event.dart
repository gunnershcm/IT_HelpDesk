part of 'solution.bloc.dart';

abstract class TicketSolutionEvent extends Equatable {
  const TicketSolutionEvent();

  @override
  List<Object> get props => [];
}

class GetAllSolutionEvent extends TicketSolutionEvent {
  final int? idSolution;

  const GetAllSolutionEvent({this.idSolution});
}