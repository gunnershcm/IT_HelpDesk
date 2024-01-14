part of 'home.bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetAllListTaskActiveEvent extends HomeEvent {
  final int? idTicket;

  const GetAllListTaskActiveEvent({this.idTicket});
}

class GetListTicketAssignEvent extends HomeEvent {}

class ClearDataEvent extends HomeEvent{}

class CreateTaskCustomer extends HomeEvent {
  final RequestTaskModel requestTaskModel;

  const CreateTaskCustomer({required this.requestTaskModel});

  @override
  List<Object> get props => [requestTaskModel];
}

class UpdateTaskTicketEvent extends HomeEvent {
  final TaskModel taskModel;

  const UpdateTaskTicketEvent({required this.taskModel});

  @override
  List<Object> get props => [taskModel];
}

class UpdateTicketEvent extends HomeEvent {
  final TicketResponseModel ticketResponseModel;

  const UpdateTicketEvent({required this.ticketResponseModel});

  @override
  List<Object> get props => [ticketResponseModel];
}

