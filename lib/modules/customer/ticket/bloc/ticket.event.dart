part of 'ticket.bloc.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

class GetAllListTicket extends TicketEvent {}


class CreateTicketEvent extends TicketEvent {
  final RequestCreateTicketModel request;

  const CreateTicketEvent({required this.request});

  @override
  List<Object> get props => [request];
}


class UpdtaeTicketEvent extends TicketEvent {
  final TicketResponseModel request;

  const UpdtaeTicketEvent({required this.request});

  @override
  List<Object> get props => [request];
}
